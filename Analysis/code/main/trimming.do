* this file is a robust check by trimming
use "$folder/data/city_panel",clear
drop if year==2010
quietly summarize ln_citation, detail      // after this r(p1) & r(p99) are stored

scalar p1  = r(p1)               // 1st-percentile value
scalar p99 = r(p99)              // 99th-percentile value

drop if ln_citation < p1 | ln_citation > p99

ivreghdfe ln_citation (fraction_of_all_immigrants=Zpredict),  cluster(city_code)
local r2 : display %6.3f e(r2)
local rkf : display %6.2f e(rkf)
outreg2 using "$output/trim.tex",replace keep(fraction_of_all_immigrants) tex(frag) nonotes nocon noobs nor2 label ///
addtext(Initial Share, No, City Controls, No, Immigrants Characteristics, No, City FE, No, Time FE, No, ///
 ~, ~, Kleibergen–Paap F-stat, `rkf', Number of Observations, `e(N)', Number of Cities, `e(N_clust)', $ R^2$, `r2')


ivreghdfe ln_citation (fraction_of_all_immigrants=Zpredict), absorb(year city_code ) cluster(city_code)
local r2 : display %6.3f e(r2)
local rkf : display %6.2f e(rkf)
outreg2 using "$output/trim.tex",append keep(fraction_of_all_immigrants) tex(frag) nonotes nocon noobs nor2 label ///
addtext(Initial Share, No, City Controls, No, Immigrants Characteristics, No, City FE, Yes, Time FE, Yes, ///
 ~, ~, Kleibergen–Paap F-stat, `rkf', Number of Observations, `e(N)', Number of Cities, `e(N_clust)', $ R^2$, `r2')

ivreghdfe ln_citation (fraction_of_all_immigrants=Zpredict) share, absorb(year city_code ) cluster(city_code)
local r2 : display %6.3f e(r2)
local rkf : display %6.2f e(rkf)
outreg2 using "$output/trim.tex",append keep(fraction_of_all_immigrants)tex(frag) nonotes nocon noobs nor2 label ///
addtext(Initial Share, Yes, City Controls, No, Immigrants Characteristics, No, City FE, Yes, Time FE, Yes, ///
 ~, ~,  Kleibergen–Paap F-stat, `rkf', Number of Observations, `e(N)', Number of Cities, `e(N_clust)', $ R^2$, `r2')
 
ivreghdfe ln_citation (fraction_of_all_immigrants=Zpredict) share pop dens_pop gdp ind_gdp stud_ratio, absorb(year city_code ) cluster(city_code)
local r2 : display %6.3f e(r2)
local rkf : display %6.2f e(rkf)
outreg2 using "$output/trim.tex",append keep(fraction_of_all_immigrants) tex(frag) nonotes nocon noobs nor2 label ///
addtext(Initial Share, Yes, City Controls, Yes, Immigrants Characteristics, No, City FE, Yes, Time FE, Yes, ///
 ~, ~,  Kleibergen–Paap F-stat, `rkf', Number of Observations, `e(N)', Number of Cities, `e(N_clust)', $ R^2$, `r2')

ivreghdfe ln_citation (fraction_of_all_immigrants=Zpredict) share pop dens_pop gdp ind_gdp stud_ratio eduy agriculture male age, absorb(year city_code ) cluster(city_code)
local r2 : display %6.3f e(r2)
local rkf : display %6.2f e(rkf)
outreg2 using "$output/trim.tex",append keep(fraction_of_all_immigrants) tex(frag) nonotes nocon noobs nor2 label ///
addtext(Initial Share, Yes, City Controls, Yes, Immigrants Characteristics, Yes, City FE, Yes, Time FE, Yes, ///
 ~, ~,  Kleibergen–Paap F-stat, `rkf', Number of Observations, `e(N)', Number of Cities, `e(N_clust)', $ R^2$, `r2')
