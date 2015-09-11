#!/bin/bash
function die_with() { echo "$*" >&2; exit 1; }
JDK_VERSION="oraclejdk7"
echo "TRAVIS_JDK_VERSION=$TRAVIS_JDK_VERSION"
[ "$TRAVIS_JDK_VERSION" != "$JDK_VERSION" ] && die_with "Not uploading because not compiled by JDK 7"
echo "Uploading files via FTP"
cd $TRAVIS_BUILD_DIR/target || die_with "Error changing to target directory"
for f in ./*.jar
do
	FILE=$(basename "$f")
	FILE="${FILE%.*}"
	tar cjf $FILE.tar.bz2 $FILE.jar || die_with "Error compressing file"
	FILE="$FILE.tar.bz2"
	echo "MD5=$(md5sum $FILE)"
	echo "SHA1=$(sha1sum $FILE)"
	md5sum $FILE > $FILE.md5sum
	sha1sum $FILE > $FILE.sha1sum
	curl -u $FTP_USER:$FTP_PASSWORD -T $FILE ftp://blazrsoft.com/gnupg-for-java/$FILE || die_with "Error uploading files"
	curl -u $FTP_USER:$FTP_PASSWORD -T $FILE.md5sum ftp://blazrsoft.com/gnupg-for-java/$FILE.md5sum || die_with "Error uploading files"
	curl -u $FTP_USER:$FTP_PASSWORD -T $FILE.sha1sum ftp://blazrsoft.com/gnupg-for-java/$FILE.sha1sum || die_with "Error uploading files"
done
for f in ./*.so
do
    FILE=$(basename "$f")
	FILE="${FILE%.*}"
	tar cjf $FILE.tar.bz2 $FILE.so || die_with "Error compressing file"
	FILE="$FILE.tar.bz2"
	echo "MD5=$(md5sum $FILE)"
    echo "SHA1=$(sha1sum $FILE)"
    md5sum $FILE > $FILE.md5sum
    sha1sum $FILE > $FILE.sha1sum
    curl -u $FTP_USER:$FTP_PASSWORD -T $FILE ftp://blazrsoft.com/gnupg-for-java/$FILE || die_with "Error uploading files"
	curl -u $FTP_USER:$FTP_PASSWORD -T $FILE.md5sum ftp://blazrsoft.com/gnupg-for-java/$FILE.md5sum || die_with "Error uploading files"
    curl -u $FTP_USER:$FTP_PASSWORD -T $FILE.sha1sum ftp://blazrsoft.com/gnupg-for-java/$FILE.sha1sum || die_with "Error uploading files"
done
echo "Script completed!"
