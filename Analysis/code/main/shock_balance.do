use "$folder/data/city_panel",clear
label var shift Shift
reghdfe share shift, absorb(year city_code ) cluster(city_code)
local r2 : display %6.3f e(r2)
outreg2 using "$output/city_shock_balance.tex",replace keep(shift) tex(frag) nonotes nocon noobs nor2 label ///
addtext(Number of Cities, `e(N_clust)', $ R^2$, `r2')

foreach v in pop_pred dens_pop gdp ind_gdp stud_ratio{
reghdfe `v' shift , absorb(year city_code ) cluster(city_code )
local r2 : display %6.3f e(r2)
outreg2 using "$output/city_shock_balance.tex",append keep(shift) tex(frag) nonotes nocon noobs nor2 label ///
addtext(Number of Cities, `e(N_clust)', $ R^2$, `r2')
}

egen id= group(city_code origin)
reghdfe eduy shift, absorb(year city_code) cluster(id)
local r2 : display %6.3f e(r2)
outreg2 using "$output/shock_balance.tex",replace keep(shift) tex(frag) nonotes nocon noobs nor2 label ///
addtext(Number of Origin-Destination, `e(N_clust)', $ R^2$, `r2')

foreach v in  agriculture male age{
	reghdfe `v' shift , absorb(year id ) cluster(id)
	local r2 : display %6.3f e(r2)
outreg2 using "$output/shock_balance.tex",append keep(shift) tex(frag) nonotes nocon noobs nor2 label ///
addtext(Number of Origin-Destination, `e(N_clust)', $ R^2$, `r2')
}