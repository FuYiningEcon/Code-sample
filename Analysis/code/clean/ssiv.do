* this file builds the shift-share IV

* 1. Compute s_{od} at baseline (year==2010)      
use "$migration/demography",clear
merge m:1 year using "$folder/data/sample_fraction.dta"
drop  _merge
keep if year==2010
gen flow = w_l * expansion
collapse (sum) nji = flow, by(city_code origin)
bysort origin: egen n_j_dot = total(nji)
gen share_ji = nji / n_j_dot
keep city_code origin share_ji
tempfile share
save `share', replace

* 2. Compute "leave-out" version shift g_{dt}
use "$migration/demography",clear
merge m:1 year using "$folder/data/sample_fraction.dta"
drop  _merge
gen flow = w_l * expansion
keep if year==migyear
collapse (sum) cityflow = flow, by(city_code year origin)
tempfile cityflow
save `cityflow', replace
collapse (sum) O_jt = cityflow, by(year origin)
tempfile totalflow
save `totalflow', replace
use `cityflow', clear
merge m:1 year origin using `totalflow'
drop  _merge
gen shift_jt = O_jt - cityflow

merge m:1 city_code origin using `share'
drop  _merge

* 3. Compute shift-share IV
merge m:1 city_code year using "$folder/data/controls/city_pop.dta"
keep if _merge==3
drop _merge

gen Z = share_ji * shift_jt/ (pop*10000)
gen dest=city_code
tostring dest,replace
replace dest=substr(dest,1,2)
destring dest,replace
drop if origin==dest

save "$migration/ssiv", replace

