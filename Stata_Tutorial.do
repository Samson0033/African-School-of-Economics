
* 				----------------------------------------------
*   					  AFRICAN SCHOOL OF ECONOMICS
* 				----------------------------------------------
* 							Stata Tutorial Part II
*   					With: Samson M'Boueke, MMES'18
*					 smboueke@africanschoolofeconomics.com
* 								October, 2017
* 				----------------------------------------------

* Useful preliminary commands
capture log close
version 13.0
clear all
set more off

					  ************* ASSIGNMENT 1 *************

				  * First Part: Loading Data, Getting an Overview

// Question 1
// Use your own working directory.
cd "D:\SAMSON\African School of Economics\Academic Year 2017-2018\TA_Samson\TA Stata\Stata Files"

// Question 2
log using samson.txt, text replace

// Question 3
use wms1998.dta

// Questions 4 & 5
des

// Question 6: soring the data acording to households and individuals
sort killil zone wereda town keftegna kebele hhld_id indiv_id

// Question 7:
global hh_key killil zone wereda town keftegna kebele hhld_id
des $hh_key

// Question 8:
local ind_key $hh_key indiv_id
des `ind_key'

				  * Second Part: Data Management
 
// Questions 1 & 2
sum
tab read_wri
tab read_wri, nol

// Question 3
list if read_wri==3
replace read_wri=. if read_wri==3

// Question 4
replace read_wri=0 if read_wri==2
mvdecode read_wri, mv(9)

// Question 5
preserve
drop if age<16 | age>97
restore

// Question 6
tab sex, nol
replace sex=0 if sex==1
replace sex=1 if sex==2
tab sex, nol
label define gender 0 "Male" 1 "Female"
label values sex gender
tab sex

// Question 7
rename sex female

// Question 8
label var female "female indicator"
label var age age

				  * Third Part: Data Management

// Question 1
tab relation female, row 
tab female if relation==0 //more efficient
gen female_head=(female==1 & relation==0)

// Question 2
sort $hh_key indiv_id
gen noind=_n
order $hh_key indiv_id noind

// Question 3
gen y=0
replace y=1 if hhld_id!= hhld_id[_n-1]
gen nohh=sum(y)
drop y

// Question 4
sort $hh_key
egen av_age=mean(age), by($hh_key)
label var av_age "average age of household"
order $hh_key age av_age
browse

// Question 5
sort $hh_key
gen x=1
egen hh_size=sum(x), by($hh_key)
label var hh_size "household size"
sum hh_size
log close



					  ************* END OF ASSIGNMENT 1 *************
					  
					  
