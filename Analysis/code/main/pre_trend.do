* this file is a robust check - pre trend test

use "$folder/data/city_panel",clear
* 1. gen interaction term
forvalues year = 2010/2016 {
	gen frac_`year'=(year==`year')*fraction_of_recent_imm
	gen Z_`year'=(year==`year')*Zpredict 
	gen hsr_`year'=(year==`year')*hispeeds
}
drop if year==2010

* 2. 2sls reg
ivreghdfe ln_citation (frac_2011 frac_2012 frac_2013 frac_2014 frac_2015 frac_2016=Z_2011 Z_2012 Z_2013 Z_2014 Z_2015 Z_2016), absorb(city_code year) cluster(city_code)

* 3. plot
cap drop coef lb ub timeindex
cap gen coef = .
cap gen lb = .
cap gen ub = .
cap gen timeindex = .

lab var coef "Coefficient"
lab var lb "Lower bound of 95% CI"
lab var ub "Upper bound of 95% CI"


local j = 1
local timevalue = 2011
levelsof year, local(time)
foreach x of local time {
  replace timeindex = `timevalue' in `j'
  
  * The coefficient for the fraction of Jewish managers in year x
  cap replace coef = _b[frac_`x'] in `j'
  * Calculate 95% lower bound: coef - z * std. error
  cap replace lb = _b[frac_`x'] - _se[frac_`x']*invttail(e(df_r),0.025) in `j'
  * Calculate 95% upper bound: coef + z * std. error
  cap replace ub = _b[frac_`x'] + _se[frac_`x']*invttail(e(df_r),0.025) in `j'
  
local j = `j' + 1
local timevalue = `timevalue' + 1
}

replace coef=coef*0.22
replace ub=ub*0.22
replace lb=lb*0.22
    
    twoway ///
        (rcap lb ub timeindex, ///
            lstyle(ci) lpattern(dash) lcolor(gray)) ///
        (scatter coef timeindex, ///
            connect(l) xline(2013.5, lcolor(red)) ///
			text(1.25 2013.6 "2014 Hukou Reform", color(red) place(e)) ///
            legend(off) xlabel(2011(1)2016) ///
            ytitle("Coefficient on migrant share (Citation)") ///
            xtitle("Year") yline(0, lcolor(black)) ///
            lcolor(black) msymbol(circle) mcolor(black) ///
            title("`ttitle'"))
graph export "$output/pre_trend_iv.png", width(2000) replace