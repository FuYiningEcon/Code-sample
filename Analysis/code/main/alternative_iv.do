* this file use alternative instrument doing robust check
* 1. Baseline IV Regression with shift-share instrument (Z)
use "$folder/data/city_panel",clear
drop if year==2010
ivreghdfe ln_citation (fraction_of_all_immigrants=Zpredict) , absorb(year city_code ) cluster(city_code)
local r2 : display %6.3f e(r2)
local rkf : display %6.2f e(rkf)
outreg2 using "$output/alternative_iv.tex",replace keep(fraction_of_all_immigrants) tex(frag) ctitle(ln citation (Baseline)) nonotes nocon noobs nor2 label ///
addtext( City FE, Yes, Time FE, Yes, ///
 ~, ~,  Kleibergen–Paap F-stat, `rkf', Number of Observations, `e(N)', Number of Cities, `e(N_clust)', $ R^2$, `r2')

* 2. IV Regression Using Transportation Shock as Instrument
* Load province-level transport quality data
use "$folder\data\railway\province panel transport quality.dta",clear
keep if year<2018
keep if year>2009
rename gbprov origin
keep origin year alllengthdensity
* Generate yearly change in length density
tsset origin year
gen change=alllengthdensity-L.alllengthdensity
keep origin year change
tempfile transport
save `transport'

* Merge with city-level panel to construct new instrument
use "$folder/data/city_panel",clear
merge m:1 origin year using `transport',keep(match) nogen
* Construct instrument: interaction of share and change in transport
gen Ztransport=share*change/ (pop*10000)
drop if year==2010

ivreghdfe ln_citation (fraction_of_all_immigrants=Ztransport) , absorb(year city_code ) cluster(city_code)
local r2 : display %6.3f e(r2)
local rkf : display %6.2f e(rkf)
outreg2 using "$output/alternative_iv.tex",append keep(fraction_of_all_immigrants) tex(frag) ctitle(ln citation (Transportation)) nonotes nocon noobs nor2 label ///
addtext( City FE, Yes, Time FE, Yes, ///
 ~, ~,  Kleibergen–Paap F-stat, `rkf', Number of Observations, `e(N)', Number of Cities, `e(N_clust)', $ R^2$, `r2')

* 3. IV Regression Using Weather Shock as Instrument
use "$folder/data/city_panel",clear
keep cname dest
duplicates drop
tempfile pcode
save `pcode'
* Prepare province-level weather shock data
use "$folder/data/weather shock",clear
keep if year<2017
keep if year>2009 
gen cname = regexr(省份, ///
    "(回族自治区|壮族自治区|维吾尔自治区|自治区|省|市)$", "")
replace cname = trim(cname)
drop 省份
merge m:1 cname using `pcode',keep(match) nogen // Merge province code
rename dest origin
rename 受灾水平受灾播种 affected
drop cname
tempfile weather
save `weather'
use "$folder/data/city_panel",clear
merge m:1 origin year using `weather'
drop if year==2010
* Construct instrument: interaction of affected level and share
gen Zweather=share*affected

ivreghdfe ln_citation (fraction_of_all_immigrants=Zweather)  , absorb(year city_code ) cluster(city_code)
local r2 : display %6.3f e(r2)
local rkf : display %6.2f e(rkf)
outreg2 using "$output/alternative_iv.tex",append keep(fraction_of_all_immigrants) tex(frag) ctitle(ln citation (Weather)) nonotes nocon noobs nor2 label ///
addtext( City FE, Yes, Time FE, Yes, ///
 ~, ~,  Kleibergen–Paap F-stat, `rkf', Number of Observations, `e(N)', Number of Cities, `e(N_clust)', $ R^2$, `r2')
