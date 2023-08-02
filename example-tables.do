* example-tables.do

clear all
version 17

run show_details.mata

sysuse auto

regress mpg
estimates store m0

regress mpg turn trunk
estimates store m1

regress mpg turn trunk i.foreign
estimates store m2

quietly etable, estimates(m0 m1 m2) column(estimates) showstars showstarsnote

collect style header result[_r_b _r_se], title(label) level(label)
collect layout (colname) (result[_r_b _r_se]#stars) (etable_estimates)

mata: show_details()

* end: example-tables.do
