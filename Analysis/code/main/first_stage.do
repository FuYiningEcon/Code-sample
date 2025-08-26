* this file is robust check of first stage
use "$folder/data/city_panel",clear

drop if year==2010

* 1. first stage regression
reghdfe fraction_of_all_immigrants Zpredict,  cluster(city_code)
local F : display %6.3f e(F)
outreg2 using "$output/first_stage.tex",replace tex(frag) nonotes nocon noobs nor2 label ///
addtext(City FE, No, Time FE, No, ///
 ~, ~, Number of Observations, `e(N)', Number of Cities, `e(N_clust)', $ F-stat$, `F')

reghdfe fraction_of_all_immigrants Zpredict, absorb(year city_code ) cluster(city_code)
local F : display %6.3f e(F)
outreg2 using "$output/first_stage.tex",append tex(frag) nonotes nocon noobs nor2 label ///
addtext(City FE, Yes, Time FE, Yes, ///
 ~, ~, Number of Observations, `e(N)', Number of Cities, `e(N_clust)', $ F-stat$, `F')

reghdfe fraction_of_all_immigrants Zpredict share, absorb(year city_code ) cluster(city_code)
local F : display %6.3f e(F)
outreg2 using "$output/first_stage.tex",append tex(frag) nonotes nocon noobs nor2 label ///
addtext(City FE, Yes, Time FE, Yes, ///
 ~, ~, Number of Observations, `e(N)', Number of Cities, `e(N_clust)', $ F-stat$, `F')

 
reghdfe fraction_of_all_immigrants Zpredict share pop dens_pop gdp ind_gdp stud_ratio , absorb(year city_code ) cluster(city_code)
local F : display %6.3f e(F)
outreg2 using "$output/first_stage.tex",append tex(frag) nonotes nocon noobs nor2 label ///
addtext(City FE, Yes, Time FE, Yes, ///
 ~, ~, Number of Observations, `e(N)', Number of Cities, `e(N_clust)', $ F-stat$, `F')

 
reghdfe fraction_of_all_immigrants Zpredict share pop dens_pop gdp ind_gdp stud_ratio eduy  agriculture male age, absorb(year city_code ) cluster(city_code)
local F : display %6.3f e(F)
outreg2 using "$output/first_stage.tex",append tex(frag) nonotes nocon noobs nor2 label ///
addtext(City FE, Yes, Time FE, Yes, ///
 ~, ~, Number of Observations, `e(N)', Number of Cities, `e(N_clust)', $ F-stat$, `F')


* 2. First_stage_actual_vs_predicted_immigration graph
reg  Zpredict i.city_code i.year share pop dens_pop gdp ind_gdp stud_ratio eduy agriculture male age , cl(city_code) 
predict Zhat,res
reg fraction_of_all i.city_code i.year  share pop dens_pop gdp ind_gdp stud_ratio eduy agriculture male age, cl(city_code) 
predict yhat,res

twoway (scatter yhat Zhat) ( lfit yhat Zhat, color(black)) , legend(off) xtitle("Predicted Fraction of Immigrants") ytitle("Actual Fraction of Immigrants") xlabel(#5 , labsize(small)) ylabel(#5,nogrid labsize(small)) 
graph export "$output/First_stage_actual_vs_predicted_immigration.png",replace
