* this file is used to calculate the patent citation of city 

clear all

* Initialize a temporary file to store results
tempfile flowall
clear
save `flowall', emptyok replace

* Main loop 
forvalues year = 2010/2016 {

    di as txt ">> Processing `year' …" // Display progress message

    use "$folder/data/patent/`year'.dta", clear   // Load yearly patent citation data      
	keep if 引用或被引用=="他引信息"| 引用或被引用=="自引信息" // keep only backward citaion
	drop if 市代码_original== 市代码
	drop if 省_original== 省
	
* Identify patent type and classify citation
	gen kind = substr(公开公告号_original, 3, 1)
	gen citation_count=1
	gen innovation   = (kind == "1")
	gen utility      = (kind == "2")
	gen self_citation = (引用或被引用=="自引信息")
	gen self_innovation = (引用或被引用=="自引信息")&(kind == "1")
	gen self_utility = (引用或被引用=="自引信息")&(kind == "2")
	gen byother_citation = (引用或被引用=="他引信息")
	
* Collapse to city-province-year level
	collapse (sum) citation_count innovation utility self_citation self_innovation self_utility byother_citation, by(市代码_original 省代码)
* Clean province code	
	capture confirm string variable 省代码
    if !_rc drop if  省代码=="NA"  
	if !_rc destring 省代码, replace ignore(" ")

	generate year = `year' 
	
* Create log-transformed variables
	foreach cita in citation_count innovation utility self_citation self_innovation self_utility byother_citation {
	gen ln_`cita'=ln(`cita'+1)
} 	
	label variable ln_citation Any
	label variable ln_innovation Innovation
	label variable ln_utility Utility
	label variable ln_self_citation "log of self-citation"
	label variable ln_byother_citation "log of citaion by other"
    append using `flowall' 
    save  `flowall', replace

}

* Final clean-up and save
use `flowall', clear

sort year 市代码_original
rename 市代码_original city_code
drop if city_code=="NA"
rename 省代码 origin
replace origin=origin/10000
destring city_code,replace

save "$folder/data/patent/citation_flow_c.dta", replace
