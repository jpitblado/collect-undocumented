* example-estars.do

clear all
version 17

run show_details.mata

sysuse auto

* estimation results with stars
regress mpg
estimates store m0

regress mpg turn trunk
estimates store m1

regress mpg turn trunk i.foreign
estimates store m2

etable, estimates(m0 m1 m2) column(estimates) showstars showstarsnote

mata: show_details()

* end: example-estars.do
