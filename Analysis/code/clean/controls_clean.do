* this file input and clean the covariates for the research

* 1. city level controls
use "$folder/data/controls/CityYearBook.dta",clear

rename 年份 year
rename 城市代码 city_code
rename 人口密度人平方公里 dens_pop
rename 人均地区生产总值元 gdp_pc
gen ind_gdp =第二产业增加值万元/地区生产总值万元
gen stud_ratio=每万人在校大学生数人/10000 
/*
rename 专利申请数件 patent_app
rename rd内部经费支出万元 rd_expenditure // very few value available
rename 常住人口城镇化率 urbanization
*/
rename 所属地域 region
keep if year<2017 & year>2009

gen cname = regexr(省份, ///
    "(回族自治区|壮族自治区|维吾尔自治区|自治区|省|市)$", "")
replace cname = trim(cname)
keep year city_code cname region ///
dens_pop gdp ind_gdp stud_ratio  

merge m:1 city_code using "$map\county-centroid.dta" 
drop if _merge==2
drop _merge
label var dens_pop "Population density"
label var gdp_pc "GDP per capita"
label var longitude "Longitude"
label var latitude   "Latitude"
label var ind_gdp "Industrial added value/GDP"
label var stud_ratio "Student ratio"
save "$folder/data/controls/controls_c.dta",replace

use "$folder/data/controls/controls_c.dta",clear
tostring city_code,replace
gen prov_code= substr(city_code,1,2)
destring prov_code,replace
keep prov_code cname year
duplicates drop
save "$folder/data/controls/prov_code.dta",replace


* 2. province level controls
clear all
cd "$folder/data/controls/raw data"
local files : dir . files "*.dta"
local master : word 1 of `files'

use "`master'", clear
foreach f of local files {
    if "`f'" != "`master'" {
        di as text "Merging `f'…"
        merge m:m province year using "`f'", nogenerate
    }
}

keep if year<=2016
keep if year>=2010
drop v5 v6 code
rename province cname

rename population                pop
rename pop_density               dens_pop

rename gdppercapita              gdp_pc
rename industrialaddedvalueregionalgdp  ind_gdp
rename numberofcollegestudentstotalpopu stud_ratio

rename numberofinventionpatentapplicati patent_app
rename lnnumberofemployee       ln_emp
rename urbanizationrate         urb_rate
rename internalexpenditureonrdfundsregi rd_exp

merge 1:1 cname year using "$folder/data/controls/prov_code.dta"
drop _merge
merge m:1 cname using  "$map/province_latitude_longitude.dta"
keep if _merge==3
drop _merge
order prov_code year cname
sort prov_code year
tempfile controls_p
save `controls_p'

* destinational province characterstics
use `controls_p',clear
foreach controls in gdp_pc ind_gdp rd_exp ln_emp stud_ratio patent_app pop dens_pop urb_rate longitude latitude{
	rename `controls' d_`controls'
}
drop prov_code
save "$folder/data/controls/controls_p.dta",replace

* origin province characterstics
use `controls_p',clear
rename prov_code origin
foreach controls in gdp_pc ind_gdp rd_exp ln_emp stud_ratio patent_app pop dens_pop urb_rate longitude latitude{
	rename `controls' o_`controls'
}
drop cname
save "$folder/data/controls/controls_p_o.dta",replace


* 3. final controls
use "$folder/data/controls/controls_c.dta",replace
merge m:1 cname year using "$folder/data/controls/controls_p.dta"
drop _merge

save "$folder/data/controls/controls.dta",replace




