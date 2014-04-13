#!/usr/bin/python
#
import os
import glob
import time

import gspread

# system configuration
#modprobe w1-gpio
#modprobe w1-therm
#echo 0 > /sys/devices/w1_bus_master1/w1_master_pullup - parasite mode

# raspberry pi ds18b20 
# Red - 3k3R - 5V
# Red - GPIO4
# White - GND

config = {}
execfile(os.getenv("HOME") + "/.gdrive.conf", config) 
gdrive_user = config["user"]
gdrive_pass = config["password"]
gdrive_key = config["temperature_key"]

base_dir = '/sys/bus/w1/devices/'
device_folder = glob.glob(base_dir + '28*')[0]
device_file = device_folder + '/w1_slave'

def read_temp_raw():
    f = open(device_file, 'r')
    lines = f.readlines()
    f.close()
    return lines

def read_temp():
    lines = read_temp_raw()
    while lines[0].strip()[-3:] != 'YES':
        time.sleep(0.2)
        lines = read_temp_raw()
    equals_pos = lines[1].find('t=')
    if equals_pos != -1:
        temp_string = lines[1][equals_pos+2:]
        temp_c = float(temp_string) / 1000.0
        return temp_c
	

temp = read_temp()
t = time.strftime("%d.%m.%y %H:%M:%S")
#print "%s;%f" % (t, temp)

gc = gspread.login (gdrive_user,gdrive_pass)
worksheet = gc.open_by_key(gdrive_key).sheet1

row = len(worksheet.col_values(1)) + 1

worksheet.update_cell(row, 1, t)
worksheet.update_cell(row, 2, temp)

