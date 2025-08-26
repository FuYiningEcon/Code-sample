* this file is for migrants type heterogeneity: high skilled immigrants

use "$folder/data/city_panel",clear
drop if year==2010

label variable fraction_of_high_skill_imm "Fr. high skilled immigrants"

ivreghdfe ln_citation (fraction_of_high_skill_imm=Zpredict),  cluster(city_code)
local r2 : display %6.3f e(r2)
local rkf : display %6.2f e(rkf)
outreg2 using "$output/high_skill.tex",replace tex(frag) nonotes nocon noobs nor2 label ///
addtext(City FE, No, Time FE, No, ///
 ~, ~, Kleibergen–Paap F-stat, `rkf', Number of Observations, `e(N)', Number of Cities, `e(N_clust)', $ R^2$, `r2')


ivreghdfe ln_citation (fraction_of_high_skill_imm=Zpredict), absorb(year city_code ) cluster(city_code)
local r2 : display %6.3f e(r2)
local rkf : display %6.2f e(rkf)
outreg2 using "$output/high_skill.tex",append tex(frag) nonotes nocon noobs nor2 label ///
addtext(City FE, Yes, Time FE, Yes, ///
 ~, ~, Kleibergen–Paap F-stat, `rkf', Number of Observations, `e(N)', Number of Cities, `e(N_clust)', $ R^2$, `r2')

ivreghdfe ln_citation (fraction_of_high_skill_imm=Zpredict) share, absorb(year city_code ) cluster(city_code)
local r2 : display %6.3f e(r2)
local rkf : display %6.2f e(rkf)
outreg2 using "$output/high_skill.tex",append tex(frag) nonotes nocon noobs nor2 label ///
addtext(City FE, Yes, Time FE, Yes, ///
 ~, ~,  Kleibergen–Paap F-stat, `rkf', Number of Observations, `e(N)', Number of Cities, `e(N_clust)', $ R^2$, `r2')

 
ivreghdfe ln_citation (fraction_of_high_skill_imm=Zpredict) share pop dens_pop, absorb(year city_code ) cluster(city_code)
local r2 : display %6.3f e(r2)
local rkf : display %6.2f e(rkf)
outreg2 using "$output/high_skill.tex",append tex(frag) nonotes nocon noobs nor2 label ///
addtext(City FE, Yes, Time FE, Yes, ///
 ~, ~,  Kleibergen–Paap F-stat, `rkf', Number of Observations, `e(N)', Number of Cities, `e(N_clust)', $ R^2$, `r2')

 
ivreghdfe ln_citation (fraction_of_high_skill_imm=Zpredict) share pop dens_pop gdp ind_gdp , absorb(year city_code ) cluster(city_code)
local r2 : display %6.3f e(r2)
local rkf : display %6.2f e(rkf)
outreg2 using "$output/high_skill.tex",append tex(frag) nonotes nocon noobs nor2 label ///
addtext(City FE, Yes, Time FE, Yes, ///
 ~, ~,  Kleibergen–Paap F-stat, `rkf', Number of Observations, `e(N)', Number of Cities, `e(N_clust)', $ R^2$, `r2')

ivreghdfe ln_citation (fraction_of_high_skill_imm=Zpredict) share pop dens_pop gdp ind_gdp stud_ratio , absorb(year city_code ) cluster(city_code)
local r2 : display %6.3f e(r2)
local rkf : display %6.2f e(rkf)
outreg2 using "$output/high_skill.tex",append tex(frag) nonotes nocon noobs nor2 label ///
addtext(City FE, Yes, Time FE, Yes, ///
 ~, ~,  Kleibergen–Paap F-stat, `rkf', Number of Observations, `e(N)', Number of Cities, `e(N_clust)', $ R^2$, `r2')

