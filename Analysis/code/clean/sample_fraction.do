* this file is used to compute the expansion weight of participants

*1. inpute target population size of survey (CMDS select participants from the china migrants system) 
clear all
input ///
year    immigrants    totalpop 
2010      221  1340.91
2011      230  1347.35
2012      236  1354.04
2013      245  1360.72
2014      253  1367.82
2015      247  1374.62
2016      245  1382.71
2017      244  1390.08
end // Input the 流动人口 series for 2010–2017 china yearbook 2019 
label variable immigrants  "total Immigrants (million)"
label variable totalpop  "total population (million)"
generate imm_flow = immigrants / totalpop //Calculate normalized immigrants (proportion)
label var imm_flow    "Normilized Immigrants"
save "$folder/data/national_total_immigrants_2011_17.dta", replace
replace year=year+1 
drop if year==2018
save "$folder/data/national_total_immigrants_2011_17_lag.dta", replace

*2. calculate sample size of survey in each year
clear
tempfile all
save `all', emptyok
foreach y of numlist 2011/2017 {
    use w_l using "$migration/`y'.dta", clear
    gen year = `y'-1 //beacuse sampling base on last year census
    append using `all'
    save `all', replace
}
collapse (sum) w_l, by(year)

*3. calculate expansion weight of each participant based on balanced weight
merge 1:1 year using "$folder/data/national_total_immigrants_2011_17.dta"
drop  _merge
gen expansion= immigrants*1000000/w_l
keep expansion year w_l
save "$folder/data/sample_fraction.dta",replace

