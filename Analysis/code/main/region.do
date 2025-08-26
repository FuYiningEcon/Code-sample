* this file is for result of regional heterogeneity

use "$folder/data/city_panel",clear
drop if year==2010

keep if region=="东部" 
label var ln_citation East

ivreghdfe ln_citation (fraction_of_all_immigrants=Zpredict) share dens_pop gdp ind_gdp stud_ratio eduy agriculture male age, absorb(year city_code ) cluster(city_code)
local r2 : display %6.3f e(r2)
local rkf : display %6.2f e(rkf)
outreg2 using "$output/region.tex",replace tex(frag) keep(fraction_of_all_immigrants) nonotes nocon noobs nor2 label ///
addtext(Initial Share, Yes, City Controls, Yes, Immigrants Characteristics, Yes, City FE, Yes, Time FE, Yes, ///
 ~, ~,  Kleibergen–Paap F-stat, `rkf',Number of Observations, `e(N)', Number of Cities, `e(N_clust)', $ R^2$, `r2')




use "$folder/data/city_panel",clear
drop if year==2010

keep if region=="中部" 
label var ln_citation Central

ivreghdfe ln_citation (fraction_of_all_immigrants=Zpredict) share dens_pop gdp ind_gdp stud_ratio eduy agriculture male age, absorb(year city_code ) cluster(city_code)
local r2 : display %6.3f e(r2)
local rkf : display %6.2f e(rkf)
outreg2 using "$output/region.tex",append tex(frag) keep(fraction_of_all_immigrants) nonotes nocon noobs nor2 label ///
addtext(Initial Share, Yes, City Controls, Yes, Immigrants Characteristics, Yes, City FE, Yes, Time FE, Yes, ///
 ~, ~,  Kleibergen–Paap F-stat, `rkf',Number of Observations, `e(N)', Number of Cities, `e(N_clust)', $ R^2$, `r2')



use "$folder/data/city_panel",clear
drop if year==2010

keep if region=="西部" 
label var ln_citation West

ivreghdfe ln_citation (fraction_of_all_immigrants=Zpredict) share dens_pop gdp ind_gdp stud_ratio eduy agriculture male age, absorb(year city_code ) cluster(city_code)
local r2 : display %6.3f e(r2)
local rkf : display %6.2f e(rkf)
outreg2 using "$output/region.tex",append tex(frag) keep(fraction_of_all_immigrants) nonotes nocon noobs nor2 label ///
addtext(Initial Share, Yes, City Controls, Yes, Immigrants Characteristics, Yes, City FE, Yes, Time FE, Yes, ///
 ~, ~,  Kleibergen–Paap F-stat, `rkf',Number of Observations, `e(N)', Number of Cities, `e(N_clust)', $ R^2$, `r2')

use "$folder/data/city_panel",clear
drop if year==2010

drop if region=="东部" 
label var ln_citation "Exclude east"

ivreghdfe ln_citation (fraction_of_all_immigrants=Zpredict) share dens_pop gdp ind_gdp stud_ratio eduy agriculture male age, absorb(year city_code ) cluster(city_code)
local r2 : display %6.3f e(r2)
local rkf : display %6.2f e(rkf)
outreg2 using "$output/region.tex",append tex(frag) keep(fraction_of_all_immigrants) nonotes nocon noobs nor2 label ///
addtext(Initial Share, Yes, City Controls, Yes, Immigrants Characteristics, Yes, City FE, Yes, Time FE, Yes, ///
 ~, ~,  Kleibergen–Paap F-stat, `rkf',Number of Observations, `e(N)', Number of Cities, `e(N_clust)', $ R^2$, `r2')

use "$folder/data/city_panel",clear
drop if year==2010

drop if region=="西部" 
label var ln_citation "Exclude west"

ivreghdfe ln_citation (fraction_of_all_immigrants=Zpredict) share dens_pop gdp ind_gdp stud_ratio eduy agriculture male age, absorb(year city_code ) cluster(city_code)
local r2 : display %6.3f e(r2)
local rkf : display %6.2f e(rkf)
outreg2 using "$output/region.tex",append tex(frag) keep(fraction_of_all_immigrants) nonotes nocon noobs nor2 label ///
addtext(Initial Share, Yes, City Controls, Yes, Immigrants Characteristics, Yes, City FE, Yes, Time FE, Yes, ///
 ~, ~,  Kleibergen–Paap F-stat, `rkf',Number of Observations, `e(N)', Number of Cities, `e(N_clust)', $ R^2$, `r2')

 
use "$folder/data/city_panel",clear
drop if year==2010

drop if region=="中部" 
label var ln_citation "Exclude central"

ivreghdfe ln_citation (fraction_of_all_immigrants=Zpredict) share dens_pop gdp ind_gdp stud_ratio eduy agriculture male age, absorb(year city_code ) cluster(city_code)
local r2 : display %6.3f e(r2)
local rkf : display %6.2f e(rkf)
outreg2 using "$output/region.tex",append tex(frag) keep(fraction_of_all_immigrants) nonotes nocon noobs nor2 label ///
addtext(Initial Share, Yes, City Controls, Yes, Immigrants Characteristics, Yes, City FE, Yes, Time FE, Yes, ///
 ~, ~,  Kleibergen–Paap F-stat, `rkf',Number of Observations, `e(N)', Number of Cities, `e(N_clust)', $ R^2$, `r2')

 
 

use "$folder/data/city_panel",clear
drop if year==2010

keep if region=="东部" 
label var ln_citation East

reghdfe ln_citation fraction_of_all_immigrant share dens_pop gdp ind_gdp stud_ratio eduy agriculture male age, absorb(year city_code ) cluster(city_code)
local r2 : display %6.3f e(r2)
local rkf : display %6.2f e(rkf)
outreg2 using "$output/region_ols.tex",replace tex(frag) keep(fraction_of_all_immigrants) nonotes nocon noobs nor2 label ///
addtext(Initial Share, Yes, City Controls, Yes, Immigrants Characteristics, Yes, City FE, Yes, Time FE, Yes, ///
 ~, ~,  Kleibergen–Paap F-stat, `rkf',Number of Observations, `e(N)', Number of Cities, `e(N_clust)', $ R^2$, `r2')




use "$folder/data/city_panel",clear
drop if year==2010

keep if region=="中部" 
label var ln_citation Central

reghdfe ln_citation fraction_of_all_immigrant share dens_pop gdp ind_gdp stud_ratio eduy agriculture male age, absorb(year city_code ) cluster(city_code)
local r2 : display %6.3f e(r2)
local rkf : display %6.2f e(rkf)
outreg2 using "$output/region_ols.tex",append tex(frag) keep(fraction_of_all_immigrants) nonotes nocon noobs nor2 label ///
addtext(Initial Share, Yes, City Controls, Yes, Immigrants Characteristics, Yes, City FE, Yes, Time FE, Yes, ///
 ~, ~,  Kleibergen–Paap F-stat, `rkf',Number of Observations, `e(N)', Number of Cities, `e(N_clust)', $ R^2$, `r2')



use "$folder/data/city_panel",clear
drop if year==2010

keep if region=="西部" 
label var ln_citation West

reghdfe ln_citation fraction_of_all_immigrant share dens_pop gdp ind_gdp stud_ratio eduy agriculture male age, absorb(year city_code ) cluster(city_code)
local r2 : display %6.3f e(r2)
local rkf : display %6.2f e(rkf)
outreg2 using "$output/region_ols.tex",append tex(frag) keep(fraction_of_all_immigrants) nonotes nocon noobs nor2 label ///
addtext(Initial Share, Yes, City Controls, Yes, Immigrants Characteristics, Yes, City FE, Yes, Time FE, Yes, ///
 ~, ~,  Kleibergen–Paap F-stat, `rkf',Number of Observations, `e(N)', Number of Cities, `e(N_clust)', $ R^2$, `r2')

use "$folder/data/city_panel",clear
drop if year==2010

drop if region=="东部" 
label var ln_citation "Exclude east"

reghdfe ln_citation fraction_of_all_immigrant share dens_pop gdp ind_gdp stud_ratio eduy agriculture male age, absorb(year city_code ) cluster(city_code)
local r2 : display %6.3f e(r2)
local rkf : display %6.2f e(rkf)
outreg2 using "$output/region_ols.tex",append tex(frag) keep(fraction_of_all_immigrants) nonotes nocon noobs nor2 label ///
addtext(Initial Share, Yes, City Controls, Yes, Immigrants Characteristics, Yes, City FE, Yes, Time FE, Yes, ///
 ~, ~,  Kleibergen–Paap F-stat, `rkf',Number of Observations, `e(N)', Number of Cities, `e(N_clust)', $ R^2$, `r2')

use "$folder/data/city_panel",clear
drop if year==2010

drop if region=="西部" 
label var ln_citation "Exclude west"

reghdfe ln_citation fraction_of_all_immigrant share dens_pop gdp ind_gdp stud_ratio eduy agriculture male age, absorb(year city_code ) cluster(city_code)
local r2 : display %6.3f e(r2)
local rkf : display %6.2f e(rkf)
outreg2 using "$output/region_ols.tex",append tex(frag) keep(fraction_of_all_immigrants) nonotes nocon noobs nor2 label ///
addtext(Initial Share, Yes, City Controls, Yes, Immigrants Characteristics, Yes, City FE, Yes, Time FE, Yes, ///
 ~, ~,  Kleibergen–Paap F-stat, `rkf',Number of Observations, `e(N)', Number of Cities, `e(N_clust)', $ R^2$, `r2')

 
use "$folder/data/city_panel",clear
drop if year==2010

drop if region=="中部" 
label var ln_citation "Exclude central"

reghdfe ln_citation fraction_of_all_immigrant share dens_pop gdp ind_gdp stud_ratio eduy agriculture male age, absorb(year city_code ) cluster(city_code)
local r2 : display %6.3f e(r2)
local rkf : display %6.2f e(rkf)
outreg2 using "$output/region_ols.tex",append tex(frag) keep(fraction_of_all_immigrants) nonotes nocon noobs nor2 label ///
addtext(Initial Share, Yes, City Controls, Yes, Immigrants Characteristics, Yes, City FE, Yes, Time FE, Yes, ///
 ~, ~,  Kleibergen–Paap F-stat, `rkf',Number of Observations, `e(N)', Number of Cities, `e(N_clust)', $ R^2$, `r2')


