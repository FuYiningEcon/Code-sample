* this file is a mechanism of how patent type affect the result.

use "$folder/data/city_panel",clear
drop if year==2010

ivreghdfe ln_innovation (fraction_of_all_immigrants=Zpredict) share dens_pop gdp ind_gdp stud_ratio eduy agriculture male age, absorb(year city_code ) cluster(city_code)
local r2 : display %6.3f e(r2)
local rkf : display %6.2f e(rkf)
outreg2 using "$output/innovation_and_utility.tex",replace tex(frag) keep(fraction_of_all_immigrants) ctitle(Invention 2SLS) nonotes nocon noobs nor2 label ///
addtext(Initial Share, Yes, City Controls, Yes, Immigrants Characteristics, Yes, City FE, Yes, Time FE, Yes, ///
 ~, ~,  Kleibergen–Paap F-stat, `rkf',Number of Observations, `e(N)', Number of Cities, `e(N_clust)', $ R^2$, `r2')
reghdfe ln_innovation fraction_of_all_immigrants share dens_pop gdp ind_gdp stud_ratio eduy agriculture male age, absorb(year city_code ) cluster(city_code)
local r2 : display %6.3f e(r2)
outreg2 using "$output/innovation_and_utility.tex",append tex(frag) keep(fraction_of_all_immigrants) ctitle(Invention OLS) nonotes nocon noobs nor2 label ///
addtext(Initial Share, Yes, City Controls, Yes, Immigrants Characteristics, Yes, City FE, Yes, Time FE, Yes, ///
 ~, ~,  ~, ~,Number of Observations, `e(N)', Number of Cities, `e(N_clust)', $ R^2$, `r2')

ivreghdfe ln_utility (fraction_of_all_immigrants=Zpredict) share dens_pop gdp ind_gdp stud_ratio eduy agriculture male age, absorb(year city_code ) cluster(city_code)
local r2 : display %6.3f e(r2)
local rkf : display %6.2f e(rkf)
outreg2 using "$output/innovation_and_utility.tex",append tex(frag) keep(fraction_of_all_immigrants) ctitle(Utility 2SLS)  nonotes nocon noobs nor2 label ///
addtext(Initial Share, Yes, City Controls, Yes, Immigrants Characteristics, Yes, City FE, Yes, Time FE, Yes, ///
 ~, ~,  Kleibergen–Paap F-stat, `rkf',Number of Observations, `e(N)', Number of Cities, `e(N_clust)', $ R^2$, `r2')
reghdfe ln_utility fraction_of_all_immigrants share dens_pop gdp ind_gdp stud_ratio eduy agriculture male age, absorb(year city_code ) cluster(city_code)
local r2 : display %6.3f e(r2)
outreg2 using "$output/innovation_and_utility.tex",append tex(frag) keep(fraction_of_all_immigrants) ctitle(Utility OLS) nonotes nocon noobs nor2 label ///
addtext(Initial Share, Yes, City Controls, Yes, Immigrants Characteristics, Yes, City FE, Yes, Time FE, Yes, ///
 ~, ~,  ~, ~,Number of Observations, `e(N)', Number of Cities, `e(N_clust)', $ R^2$, `r2')