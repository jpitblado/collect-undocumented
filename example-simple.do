* example-simple.do

clear all
version 17

run show_details.mata

sysuse auto

table for, stat(frequency) stat(percent) sformat("%s%%" percent)

mata: show_details()

* end: example-simple.do
