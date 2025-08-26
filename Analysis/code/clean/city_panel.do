* This file builds the main panel data of dissertation

*1. collapse migration flow characteristic at city origin level 
use "$migration/demography",clear
merge m:1 year using "$folder/data/sample_fraction.dta"
drop  _merge
gen age= year-birthy
collapse (mean) eduy agriculture male age [aw = w_l], by(city_code origin year)
gen dest=city_code
tostring dest,replace
replace dest=substr(dest,1,2)
destring dest,replace
drop if dest==origin
tempfile demo
save `demo'

use "$migration/demography",clear
merge m:1 year using "$folder/data/sample_fraction.dta"
drop  _merge
* compute each count (set to zero when the condition fails)
gen immigrants_count   = w_l * expansion
gen high_skill_count   = w_l * expansion if eduy > 12
gen low_skill_count   = w_l * expansion if eduy < 13
gen recent_count       = w_l * expansion if migyear == year
gen recent_high_skill_count   = w_l * expansion if eduy > 12 & migyear == year

* collapse sums by city_code x origin x year 
collapse (sum) ///
    immigrants_count ///
    high_skill_count ///
	low_skill_count ///
    recent_count ///
	recent_high_skill_count , by(city_code origin year )

gen dest=city_code
tostring dest,replace
replace dest=substr(dest,1,2)
destring dest,replace
drop if dest==origin

merge 1:1 city_code origin year using `demo',nogen


* bring in pop
merge m:1 city_code year using "$folder/data/controls/city_pop.dta",keep(match) nogen
merge m:1 city_code year using "$folder/data/controls/predict_pop.dta",keep(match) nogen
* generate fractions 
gen fraction_of_all_immigrants   = immigrants_count  / (pop * 10000)
gen fraction_of_high_skill_imm   = high_skill_count  / (pop * 10000)
gen fraction_of_low_skill_imm   = low_skill_count  / (pop * 10000)
gen fraction_of_recent_imm       = recent_count      / (pop * 10000)
gen fraction_of_recent_hig       = recent_high_skill_count/(pop*10000)
gen pred_fraction_of_all_immigrants   = immigrants_count  / (pop_predict * 10000)
gen pred_fraction_of_high_skill_imm   = high_skill_count  / (pop_predict * 10000)
gen pred_fraction_of_low_skill_imm   = low_skill_count  / (pop_predict * 10000)
gen pred_fraction_of_recent_imm       = recent_count      / (pop_predict * 10000)
gen pred_fraction_of_recent_hig       = recent_high_skill_count/(pop_predict*10000)

* 2. merge other part of panel
* merge ciatation data
merge m:1 origin city_code year using "$folder/data/patent/citation_flow_c.dta"
drop if _merge==2
drop _merge

* merge shift-share IV
merge 1:1 origin city_code year using "$migration/ssiv"
keep if _merge==3
drop _merge
drop if Z==.
gen Zpredict=share*shift/ (pop_predict*10000)

* merge control variables
merge m:1 city_code year using "$folder/data/controls/controls.dta"
keep if _merge==3
drop _merge
merge m:1 origin year using "$folder/data/controls/controls_p_o.dta"
keep if _merge==3
drop _merge
merge m:1 city_code year using "$folder/data/railway/access to hispeedrailway.dta"
keep if _merge==3
drop _merge
gen east=(region=="东部")
geodist latitude longitude o_latitude o_longitude , gen(dist_km)

* 3. label variables and save
label var dist_km "Distance"
label var fraction_of_all_immigrants   "Fr. immigrants"
label var fraction_of_high_skill_imm   "Fr. high-skill immigrants"
label var fraction_of_recent_imm       "Fr. recent immigrants"
label var fraction_of_recent_hig       "Fr. recent high-skill imm."
label var pop "City population (10,000)"
label var dens_pop "Population density "
label var citation_count               "No. Citations"
label var innovation                "No. Citations of invention patent"
label var utility                "No. Citations of utility patent"
label var east "Share of city in the east"
label var ln_citation "Citation"
label var ln_innovation "Invention"
label var share "Initial share" 
label var agriculture "Rural hukou ratio"
label var male "Male share"
label var eduy "Average education years"  
label var age "Average age"

save "$folder/data/city_panel",replace