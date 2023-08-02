* example-composites.do

clear all
version 17

run show_details.mata

sysuse auto

quietly				///
table foreign,			///
	stat(frequency)		///
	stat(percent)		///
	stat(mean mpg turn)	///
	stat(sd mpg turn)	///
	stat(fvfrequency rep78)	///
	stat(fvpercent rep78)
collect recode var _hide = N, fortags(result[frequency percent])
collect style header result, title(hide) level(hide)
collect style row stack, nobinder
collect style column, extraspace(0)
collect style cell result[mean sd], nformat(%18.3f)
collect style cell result[percent fvpercent], sformat("(%s%%)")
collect style cell result[sd], sformat("(%s)")
collect style cell border_block[corner row-header], ///
	border(right, pattern(none))
collect composite define	///
	spec =	frequency	///
		percent		///
		mean		///
		sd		///
		fvfrequency	///
		fvpercent	///
	,			///
	trim
collect layout (var) (foreign#result[spec])

mata: show_details()

* end: example-composites.do
