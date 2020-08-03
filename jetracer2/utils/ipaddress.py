import subprocess
import display

def network_interface_state(interface):
    try:
        with open('/sys/class/net/%s/operstate' % interface, 'r') as f:
            return f.read()
    except:
        return None

def ip_address(interface):
    try:
        if network_interface_state(interface) == None:
            return None
        cmd = "ifconfig %s | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'" % interface
        return subprocess.check_output(cmd, shell=True).decode('ascii')[:-1]
    except:
        return "None"

def get_ip_address_all():
    return "eth0:" + ip_address("eth0") + "\n" + "wla0:" + ip_address("wlan0")

def get_ip_address_eth0():
    return "eth0:" + ip_address("eth0")

def get_ip_address_wlan0():
    return "wlan0:" + ip_address("wlan0")

if __name__ == "__main__":
    oled = display.Oled()
    oled.set_text(get_ip_address_wlan0())