1. Install Package
  $ sudo apt-get update
  $ sudo apt install python3-pip python3-pil python3-smbus -y

2. Setup
  $ sudo usermod -aG i2c $USER  # Set our access to I2C permissions
  $ sudo udevadm control --reload-rules && sudo udevadm trigger
  $ sudo reboot

3. Install JetRacer Package
  $ cd
  $ git clone https://github.com/waveshare/jetracer
  $ cd jetracer
  $ sudo python3 setup.py install

4. Python Package
  $ cd /usr/local/lib/python3.6/dist-packages
  $ sudo unzip jetracer-0.0.0-py3.6egg 로 압축해제한다
  $ sudo pip3 install traitlets
  $ sudo pip3 install image
  $ sudo pip3 install Adafruit-SSD1306
