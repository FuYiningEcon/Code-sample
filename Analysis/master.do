********************************************************************************
*	MASTER FILE TO RUN THE ENTIRE ANALYSIS
********************************************************************************

clear all
global folder "C:/Users/fuyin/OneDrive - University of Bristol/0 Dissertation/Analysis" // change to your path here
global migration "$folder/data/migration"
global output "$folder/output"
global map "$folder/data/map"

foreach pkg in ivreg2 reghdfe ivreghdfe ftools outreg2 estout {
    capture which `pkg'            
    if _rc ssc install `pkg',replace
}

cd "$folder"

*clean

run "$folder/code/clean/patent_city_level.do"
run "$folder/code/clean/sample_fraction.do"
run "$folder/code/clean/demography.do" //CMDS and city_code
run "$folder/code/clean/city_pop.do" //cityyearbook
run "$folder/code/clean/controls_clean.do"
run "$folder/code/clean/predict_pop.do"
run "$folder/code/clean/ssiv.do"
run "$folder/code/clean/city_panel.do"

*main
*data description
run "$folder/code/main/map.do"
run "$folder/code/main/summary_statistics.do"

*result
run "$folder/code/main/ols_and_2sls.do"
run "$folder/code/main/high_skilled.do"
run "$folder/code/main/recent.do"
run "$folder/code/main/region.do"
run "$folder/code/main/invention_utility.do"
run "$folder/code/main/self.do"

*Robust 
run "$folder/code/main/first_stage.do"
run "$folder/code/main/pre_trend.do"
run "$folder/code/main/alternative_iv.do"
run "$folder/code/main/robust_predict_pop.do"
run "$folder/code/main/trimming.do"
run "$folder/code/main/shock_balance.do"

*Code edit
/*
doedit "$folder/code/clean/patent_city_level.do"
doedit "$folder/code/clean/sample_fraction.do"
doedit "$folder/code/clean/demography.do" //CMDS and city_code
doedit "$folder/code/clean/city_pop.do" //cityyearbook
doedit "$folder/code/clean/controls_clean.do"
doedit "$folder/code/clean/predict_pop.do"
doedit "$folder/code/clean/ssiv.do"
doedit "$folder/code/clean/city_panel.do"

doedit "$folder/code/main/summary_statistics.do"
doedit "$folder/code/main/map.do"

doedit "$folder/code/main/ols_and_2sls.do"
doedit "$folder/code/main/high_skilled.do"
doedit "$folder/code/main/recent.do"
doedit "$folder/code/main/region.do"
doedit "$folder/code/main/invention_utility.do"
doedit "$folder/code/main/self.do"

doedit "$folder/code/main/first_stage.do"
doedit "$folder/code/main/pre_trend.do"
doedit "$folder/code/main/alternative_iv.do"
doedit "$folder/code/main/robust_predict_pop.do"
doedit "$folder/code/main/trimming.do"
doedit "$folder/code/main/shock_balance.do"
*/

