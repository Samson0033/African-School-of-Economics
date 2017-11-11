
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

					  ************* ASSIGNMENT 2 *************

				  * First Part: Descriptive Analysis

// Question 1
cd "D:\SAMSON\African School of Economics\Academic Year 2017-2018\TA_Samson\TA Stata\Stata Files"
log using samson2.txt, text replace
use fertility
gen educ7=(educ>=7)
tab educ7, nol

// Question 2
bysort educ7: tab children
// 15.31% of women having attained less than 7 years of education report having 
// no child, while 35.16% of those having attained 7 years of education or more 
// report having no child

bysort educ7: sum children if children>0
// For women who have at least one child, those with 7 years of education or more have 
// on average 2.3 children, while those with less than 7 years of education have 3.8
// children on average 

histogram children, discrete by(educ7)
histogram children if children > 0, discrete by(educ7)
sum agefbrth
// The average age of women at their first birth is 19

bysort educ7: sum agefbrth
// Average age at birth is 18.8 if educ7 = 0, and 19.2 if educ7 = 1. This means
// more educated women get their first child later than less educated women 

//Plotting differences
twoway histogram agefbrth, discrete by(educ7)
kdensity agefbrth if educ7 == 1, gen(x kage_1) w(0.9)
kdensity agefbrth if educ7 == 0, gen(kage_0) at(x) w(0.9)

label var kage_1 "educ7 = 1"
label var kage_0 "educ7 = 0"
line kage_1 kage_0 x, legend(cols(1)) title("Kernel densities") ytitle("density") xlabel(10 15 20 25 30 35) ylabel(0 0.05 0.10 0.15)

// Question 3
global list_all age evermarr urban electric tv usemeth religion
bysort educ7: sum $list_all, sep(0)
// More educated women tend to be younger, single, they live in urban areas 
// and have electricity and TV. They are also more likely to use contraception methods, 
// and to be catholic or protestant

bysort educ7: sum heduc if evermarr>0
// More educated women that are married tend to have more educated husbands

				  
				  * Second Part: Regressison Methods

		// Please use your Statistics and Econometrics courses to interpret
		// the results of this part. Only codes are provided
				  
// Question 1
reg children educ7
gen agesq=(age*age)/100
global list_new age agesq evermarr urban electric tv usemeth heduc religion
sum $list_new, sep(0)
reg children educ7 $list_new
more

// Question 2
regress agefbrth educ7 $list_all if agefbrth ~= .
more

// Question 3
sum urban educ 
// Mean of urb: 0.5200288; mean of age: 27.15064
gen urb_edu = (urban - .5200288)*educ
gen age_edu = (age - 27.15067)*educ
regress children educ7 $list_all urb_edu age_edu
more


					  ************* END OF ASSIGNMENT 2 *************
					  
					  
