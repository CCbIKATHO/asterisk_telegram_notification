cd /usr/local/src
sudo wget https://www.openssl.org/source/openssl-1.1.1l.tar.gz
sudo tar xzf openssl-1.1.1l.tar.gz
cd openssl-1.1.1l
sudo ./config --prefix=/usr/local/openssl --openssldir=/usr/local/openssl shared zlib
sudo make
sudo make install
cd /usr/local/src
sudo wget https://www.python.org/ftp/python/3.10.14/Python-3.10.14.tgz
sudo tar xzf Python-3.10.14.tgz
cd Python-3.10.14
sudo ./configure --with-openssl=/usr/local/openssl --enable-optimizations
sudo make
sudo make altinstall
python3.10 -m pip install --upgrade pip
pip3.10 install cython
pip3.10 install python-telegram-bot==12.8
