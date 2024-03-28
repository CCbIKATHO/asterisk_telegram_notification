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
mkdir /home/asterisk
mkdir /home/asterisk/bot
git clone https://github.com/CCbIKATHO/telegram_bot.git
mv telegram_bot bot
chmod +x /home/asterisk/bot/bot.sh
touch /etc/systemd/system/telegram-bot.service
chmod 664 /etc/systemd/system/telegram-bot.service
tee -a /etc/systemd/system/telegram-bot.service << EOF
[Unit]
Description=Telegram bot
After=network.target
[Service]
ExecStart=/home/asterisk/bot/bot.sh
[Install]
WantedBy=multi-user.target
EOF
systemctl start telegram-bot.service
systemctl enable telegram-bot.service
systemctl status telegram-bot.service
mkdir /home/asterisk/scripts
touch /home/asterisk/scripts/GSM1.sh
touch /home/asterisk/scripts/GSM1_number.sh
touch /home/asterisk/scripts/GSM1_reload.sh
touch /home/asterisk/scripts/all.sh
touch /home/asterisk/scripts/reboot.sh
tee -a /home/asterisk/scripts/GSM1.sh << EOF
#!/bin/sh
printf "dongle ussd GSM1 *101#\nexit" | /usr/sbin/asterisk -vrrrr
sleep 10
EOF
tee -a /home/asterisk/scripts/GSM1_number.sh << EOF
#!/bin/sh
printf "dongle ussd GSM1 *161#\nexit" | /usr/sbin/asterisk -vrrrr
sleep 10
EOF
tee -a /home/asterisk/scripts/GSM1_reload.sh << EOF
#!/bin/sh
printf "dongle reset GSM1\nexit" | /usr/sbin/asterisk -vrrrr
sleep 60
EOF
tee -a /home/asterisk/scripts/all.sh << EOF
#!/bin/sh
printf "dongle ussd GSM1 *101#\nexit" | /usr/sbin/asterisk -vrrrr
sleep 10
printf "dongle ussd GSM1 *161#\nexit" | /usr/sbin/asterisk -vrrrr
sleep 10
EOF
tee -a /home/asterisk/scripts/reboot.sh << EOF
#!/bin/sh
reboot
EOF
