* this file is for robust check using predict population

use "$folder/data/city_panel",clear
drop if year==2010
gen predict_fraction=immigrants_count/pop_predict
label var predict_fraction "Immigrants/Predict Population"
ivreghdfe ln_citation (predict_fraction=Zpredict),  cluster(city_code)
local r2 : display %6.3f e(r2)
local rkf : display %6.2f e(rkf)
outreg2 using "$output/pop_predict.tex",replace keep(predict_fraction) tex(frag) nonotes nocon noobs nor2 label ///
addtext(Initial Share, No, City Controls, No, Immigrants Characteristics, No, City FE, No, Time FE, No, ///
 ~, ~, Kleibergen–Paap F-stat, `rkf', Number of Observations, `e(N)', Number of Cities, `e(N_clust)', $ R^2$, `r2')


ivreghdfe ln_citation (predict_fraction=Z), absorb(year city_code ) cluster(city_code)
local r2 : display %6.3f e(r2)
local rkf : display %6.2f e(rkf)
outreg2 using "$output/pop_predict.tex",append keep(predict_fraction) tex(frag) nonotes nocon noobs nor2 label ///
addtext(Initial Share, No, City Controls, No, Immigrants Characteristics, No, City FE, Yes, Time FE, Yes, ///
 ~, ~, Kleibergen–Paap F-stat, `rkf', Number of Observations, `e(N)', Number of Cities, `e(N_clust)', $ R^2$, `r2')

ivreghdfe ln_citation (predict_fraction=Z) share, absorb(year city_code ) cluster(city_code)
local r2 : display %6.3f e(r2)
local rkf : display %6.2f e(rkf)
outreg2 using "$output/pop_predict.tex",append keep(predict_fraction)tex(frag) nonotes nocon noobs nor2 label ///
addtext(Initial Share, Yes, City Controls, No, Immigrants Characteristics, No, City FE, Yes, Time FE, Yes, ///
 ~, ~,  Kleibergen–Paap F-stat, `rkf', Number of Observations, `e(N)', Number of Cities, `e(N_clust)', $ R^2$, `r2')
 
ivreghdfe ln_citation (predict_fraction=Z) share pop dens_pop gdp ind_gdp stud_ratio, absorb(year city_code ) cluster(city_code)
local r2 : display %6.3f e(r2)
local rkf : display %6.2f e(rkf)
outreg2 using "$output/pop_predict.tex",append keep(predict_fraction) tex(frag) nonotes nocon noobs nor2 label ///
addtext(Initial Share, Yes, City Controls, Yes, Immigrants Characteristics, No, City FE, Yes, Time FE, Yes, ///
 ~, ~,  Kleibergen–Paap F-stat, `rkf', Number of Observations, `e(N)', Number of Cities, `e(N_clust)', $ R^2$, `r2')

ivreghdfe ln_citation (predict_fraction=Z) share pop dens_pop gdp ind_gdp stud_ratio eduy agriculture male age, absorb(year city_code ) cluster(city_code)
local r2 : display %6.3f e(r2)
local rkf : display %6.2f e(rkf)
outreg2 using "$output/pop_predict.tex",append keep(predict_fraction) tex(frag) nonotes nocon noobs nor2 label ///
addtext(Initial Share, Yes, City Controls, Yes, Immigrants Characteristics, Yes, City FE, Yes, Time FE, Yes, ///
 ~, ~,  Kleibergen–Paap F-stat, `rkf', Number of Observations, `e(N)', Number of Cities, `e(N_clust)', $ R^2$, `r2')

