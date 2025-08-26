* this file is summary statistics
* 1. summary table
use "$folder/data/city_panel.dta",clear
label var ln_citation_count Citation
eststo clear    
estpost summarize ///
        fraction_of_all_immigrants ///
        fraction_of_high_skill_imm ///
        fraction_of_recent_imm ///
        fraction_of_recent_hig ///
        pop pop_predict dens_pop ///
        ln_citation_count ///
		ln_innovation ///
		ln_utility  ///
		gdp_pc ind_gdp stud_ratio eduy agriculture male age, detail

esttab using `"${output}/summary.tex"', ///
    cells("mean(fmt(3)) p50(fmt(3)) sd(fmt(3)) min(fmt(3)) max(fmt(3)) count(fmt(0))") ///
    collabels("Mean" "Median" "St. Dev." "Min" "Max" "Obs.") ///
    label nonumber noobs booktabs replace

* 2. national migrants rates
use "$folder/data/national_total_immigrants_2011_17.dta",clear
twoway (line imm_flow year, sort), ///
    title("") ///
    xlabel(2010(1)2016) ///
    ylabel( , angle(horizontal)) ///
    ytitle("Fraction of Internal Migrants of China") ///
    xtitle("Year") ///
    scheme(s1color)
graph export "$folder/output/fraction_of_internal_migrants.png", replace

* 3. citation counts of all cities
use "$folder/data/city_panel.dta",clear
collapse (sum) citation_count, by(year)
twoway (line citation year, sort), ///
    xlabel(2010(1)2016) ///
    ylabel(0(500000)3000000, format(%12.0f) angle(horizontal)) ///
    ytitle("Citation Count") ///
    xtitle("Year") ///
    scheme(s1color)
graph export "$folder/output/Citation_over_time.png", replace

* 4. sample size
use "$folder/data/sample_fraction.dta",clear
twoway (line w_l year, sort), ///
    xlabel(2010(1)2016) ///
    ylabel(110000(10000)220000, angle(horizontal)) ///
    ytitle("Migrant Count") ///
    xtitle("Year") ///
    scheme(s1color)
graph export "$folder/output/sample_size.png", replace






