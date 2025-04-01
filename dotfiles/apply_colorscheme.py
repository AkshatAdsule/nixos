#!/usr/bin/env python

from os import system
import time

SUNSET_TIME = 19 # 7pm
SUNRISE_TIME = 6 # 6am

def is_daytime():
    current_hour = time.localtime().tm_hour
    return SUNRISE_TIME <= current_hour < SUNSET_TIME

if is_daytime():
    system("plasma-apply-colorscheme BreezeLight")
else:
    system("plasma-apply-colorscheme BreezeDark")
