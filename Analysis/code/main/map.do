* This file is some summary stat showing by map. 
* 1. city immigrants share

forvalues year = 2010/2016 {

use "$folder/data/city_panel",clear
collapse (sum) fraction_of_all_imm,by(city_code year)
rename city_code citycode
keep if year ==`year'
keep citycode fraction_of_all_imm
merge 1:1 citycode using "$map/city_map_id"
replace fraction_of_all_imm=-1 if fraction_of_all_imm==.
drop _merge

grmap, activate
grmap fraction_of_all_imm using "$map/chinacity2020_coord.dta", ///
	id(ID) osize(vvthin ...) ocolor(white ...) ///
	clmethod(custom) clbreaks(-1  0 0.01 0.5 1 10) ///
	fcolor("gs10" "224 242 241" "178 223 219" "128 203 196" "77 182 172" "38 166 154") ///
	leg(order(2 "No data" 3 "<1%" 4 "1%-50%" 5 "50%-100%" 6  ">100%" )) ///
	graphr(margin(medium)) ///
	line(data("$map/chinacity2020_line_coord3.dta") by(group) ///
		size(vvthin *1 *0.5 *0.5 *0.5) pattern(solid ...) ///
		select(drop if inlist(group, 4, 7)) ///
		color(white black "0 85 170" black black)) ///
	polygon(data("$map/polygon3") fcolor(black) osize(vvthin)) ///
	caption("Year:`year'", size(*0.8)) ///
	label(data("$map/chinacity2020_label3") x(X) y(Y) label(ename) length(20) size(*0.8)) 
	
gr export "$output/figure_immgrants_share_`year'.png", replace width(1200)

}

* 2. province emigrants average counts

use "$folder/data/city_panel.dta",clear
collapse (sum)immigrants_count high_skill_count low_skill_count recent_count recent_high_skill_count,by(origin)
foreach v in immigrants_count high_skill_count low_skill_count recent_count recent_high_skill_count{
	replace `v'=`v'/7
}

keep origin recent_count
replace origin=origin*10000
rename origin 省代码
merge 1:m 省代码 using  "$map\chinaprov40_db.dta"
drop _merge

grmap recent_count using "$map/chinaprov40_coord", 
	id(ID) osize(vvthin ...) ocolor(white ...)
gr export "$output/migration_origin.png", replace width(1200)	
	
* 2. province emigrants to selected city
foreach ctcode in 110000 310000 420100 500000{
	use "$folder/data/city_panel.dta",clear
	keep if city_code==`ctcode'
	collapse (sum)recent_count,by(origin city_code)
	replace recent_count=recent_count/7
	sort recent_count
	drop city_code
	replace origin=origin*10000
	rename origin 省代码
	
	merge 1:m 省代码 using  "$map\chinaprov40_db.dta"
	drop _merge
	
	grmap recent_count using "$map/chinaprov40_coord", 
		id(ID) osize(vvthin ...) ocolor(white ...)
	gr export "$output/origin_`ctcode'.png", replace width(1200)	
}


foreach ctcode in 110000 310000 420100 500000{
	use "$folder/data/city_panel.dta",clear
	keep if city_code==`ctcode'
	collapse (sum)fraction_of_recent_imm,by(origin city_code)
	replace fraction_of_recent_imm=fraction_of_recent_imm/7
	sort fraction_of_recent_imm
	drop city_code
	replace origin=origin*10000
	rename origin 省代码
	
	merge 1:m 省代码 using  "$map\chinaprov40_db.dta"
	drop _merge
	
	grmap fraction_of_recent_imm using "$map/chinaprov40_coord", 
		id(ID) osize(vvthin ...) ocolor(white ...)
	gr export "$output/origin_share_`ctcode'.png", replace width(1200)	
	
}

