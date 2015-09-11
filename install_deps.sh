#!/bin/sh
set -ex
wget https://www.gnupg.org/ftp/gcrypt/libgpg-error/libgpg-error-1.20.tar.bz2 || exit 2
tar xf libgpg-error-1.20.tar.bz2 || exit 2
cd libgpg-error-1.20 || exit 2
./configure || exit 2
make || exit 2
sudo make install || exit 2
cd ..

wget https://www.gnupg.org/ftp/gcrypt/libassuan/libassuan-2.3.0.tar.bz2 || exit 2
tar xf libassuan-2.3.0.tar.bz2 || exit 2
cd libassuan-2.3.0 || exit 2
./configure || exit 2
make || exit 2
sudo make install || exit 2
cd ..

wget https://www.gnupg.org/ftp/gcrypt/gpgme/gpgme-1.6.0.tar.bz2 || exit 2
tar xf gpgme-1.6.0.tar.bz2 || exit 2
cd gpgme-1.6.0 || exit 2
./configure || exit 2
make || exit 2
sudo make install || exit 2


