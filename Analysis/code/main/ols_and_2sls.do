* this file is the main result of dissertation

use "$folder/data/city_panel",clear
drop if year==2010
* 1. ols
reghdfe ln_citation fraction_of_all_immigrants,  cluster(city_code)
local r2 : display %6.3f e(r2)
outreg2 using "$output/main_ols.tex",replace keep(fraction_of_all_immigrants) tex(frag) nonotes nocon noobs nor2 label ///
addtext(Initial Share, No, City Controls, No, Immigrants Characteristics, No, City FE, No, Time FE, No, ///
 ~, ~, Number of Observations, `e(N)', Number of Cities, `e(N_clust)', $ R^2$, `r2')


reghdfe ln_citation fraction_of_all_immigrants, absorb(year city_code ) cluster(city_code)
local r2 : display %6.3f e(r2)
outreg2 using "$output/main_ols.tex",append  keep(fraction_of_all_immigrants) tex(frag) nonotes nocon noobs nor2 label ///
addtext(Initial Share, No, City Controls, No, Immigrants Characteristics, No, City FE, Yes, Time FE, Yes, ///
 ~, ~, Number of Observations, `e(N)', Number of Cities, `e(N_clust)', $ R^2$, `r2')

reghdfe ln_citation fraction_of_all_immigrants share, absorb(year city_code ) cluster(city_code)
local r2 : display %6.3f e(r2)
outreg2 using "$output/main_ols.tex",append  keep(fraction_of_all_immigrants) tex(frag) nonotes nocon noobs nor2 label ///
addtext(Initial Share, Yes, City Controls, No, Immigrants Characteristics, No, City FE, Yes, Time FE, Yes, ///
 ~, ~, Number of Observations, `e(N)', Number of Cities, `e(N_clust)', $ R^2$, `r2')

 
reghdfe ln_citation fraction_of_all_immigrants share pop dens_pop gdp ind_gdp stud_ratio, absorb(year city_code ) cluster(city_code)
local r2 : display %6.3f e(r2)
outreg2 using "$output/main_ols.tex",append  keep(fraction_of_all_immigrants) tex(frag) nonotes nocon noobs nor2 label ///
addtext(Initial Share, Yes, City Controls, Yes, Immigrants Characteristics, No, City FE, Yes, Time FE, Yes, ///
 ~, ~, Number of Observations, `e(N)', Number of Cities, `e(N_clust)', $ R^2$, `r2')
 
reghdfe ln_citation fraction_of_all_immigrants share pop dens_pop gdp ind_gdp stud_ratio eduy agriculture male age, absorb(year city_code ) cluster(city_code)
local r2 : display %6.3f e(r2)
outreg2 using "$output/main_ols.tex",append  keep(fraction_of_all_immigrants) tex(frag) nonotes nocon noobs nor2 label ///
addtext(Initial Share, Yes, City Controls, Yes, Immigrants Characteristics, Yes, City FE, Yes, Time FE, Yes, ///
 ~, ~, Number of Observations, `e(N)', Number of Cities, `e(N_clust)', $ R^2$, `r2')


* 2. 2sls


ivreghdfe ln_citation (fraction_of_all_immigrants=Zpredict),  cluster(city_code)
local r2 : display %6.3f e(r2)
local rkf : display %6.2f e(rkf)
outreg2 using "$output/main_2sls.tex",replace keep(fraction_of_all_immigrants) tex(frag) nonotes nocon noobs nor2 label ///
addtext(Initial Share, No, City Controls, No, Immigrants Characteristics, No, City FE, No, Time FE, No, ///
 ~, ~, Kleibergen–Paap F-stat, `rkf', Number of Observations, `e(N)', Number of Cities, `e(N_clust)', $ R^2$, `r2')


ivreghdfe ln_citation (fraction_of_all_immigrants=Zpredict), absorb(year city_code ) cluster(city_code)
local r2 : display %6.3f e(r2)
local rkf : display %6.2f e(rkf)
outreg2 using "$output/main_2sls.tex",append keep(fraction_of_all_immigrants) tex(frag) nonotes nocon noobs nor2 label ///
addtext(Initial Share, No, City Controls, No, Immigrants Characteristics, No, City FE, Yes, Time FE, Yes, ///
 ~, ~, Kleibergen–Paap F-stat, `rkf', Number of Observations, `e(N)', Number of Cities, `e(N_clust)', $ R^2$, `r2')

ivreghdfe ln_citation (fraction_of_all_immigrants=Zpredict) share, absorb(year city_code ) cluster(city_code)
local r2 : display %6.3f e(r2)
local rkf : display %6.2f e(rkf)
outreg2 using "$output/main_2sls.tex",append keep(fraction_of_all_immigrants)tex(frag) nonotes nocon noobs nor2 label ///
addtext(Initial Share, Yes, City Controls, No, Immigrants Characteristics, No, City FE, Yes, Time FE, Yes, ///
 ~, ~,  Kleibergen–Paap F-stat, `rkf', Number of Observations, `e(N)', Number of Cities, `e(N_clust)', $ R^2$, `r2')
 
ivreghdfe ln_citation (fraction_of_all_immigrants=Zpredict) share pop dens_pop gdp ind_gdp stud_ratio, absorb(year city_code ) cluster(city_code)
local r2 : display %6.3f e(r2)
local rkf : display %6.2f e(rkf)
outreg2 using "$output/main_2sls.tex",append keep(fraction_of_all_immigrants) tex(frag) nonotes nocon noobs nor2 label ///
addtext(Initial Share, Yes, City Controls, Yes, Immigrants Characteristics, No, City FE, Yes, Time FE, Yes, ///
 ~, ~,  Kleibergen–Paap F-stat, `rkf', Number of Observations, `e(N)', Number of Cities, `e(N_clust)', $ R^2$, `r2')

ivreghdfe ln_citation (fraction_of_all_immigrants=Zpredict) share pop dens_pop gdp ind_gdp stud_ratio eduy agriculture male age, absorb(year city_code ) cluster(city_code)
local r2 : display %6.3f e(r2)
local rkf : display %6.2f e(rkf)
outreg2 using "$output/main_2sls.tex",append keep(fraction_of_all_immigrants) tex(frag) nonotes nocon noobs nor2 label ///
addtext(Initial Share, Yes, City Controls, Yes, Immigrants Characteristics, Yes, City FE, Yes, Time FE, Yes, ///
 ~, ~,  Kleibergen–Paap F-stat, `rkf', Number of Observations, `e(N)', Number of Cities, `e(N_clust)', $ R^2$, `r2')
