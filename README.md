# How Internal Immigration Drives Knowledge Inflow: Insights from China’s Patent Citations

## Input data:
Main panel:
"city_panel.dta" 
  *get by merging CNIPA patent citation data 2010-2016, CMDS migrants data 2011-2017 waves and China City Statistical Yearbook 2010-2016

National migration data: "national_total_immigrants_2011_17.dta"

Map data: "chinacity2020_coord.dta" "chinacity2020_label3" "chinacity2020_line_coord3.dta" "polygon3""

Alternative IV: "province panel transport quality.dta" "weather shock.dta"

## Output
List of Tables

Table 1: Data Sources

Table 2: Summary Statistics

Table 3: Instrument Relevance: First-Stage Regression of Immigrant Share on Shift-Share Instrument

Table 4: OLS: The Effect of Immigrants on Knowledge Inflow

Table 5: 2SLS: The Effect of Immigrants on Knowledge Inflow

Table 6: The Effect of High-Skilled Immigrants on Knowledge Inflow

Table 7: The Effect of Recent Immigrants on Knowledge Inflow

Table 8: Regional Heterogeneity in the Effect of Immigrants on Knowledge Inflow (2SLS)

Table 9: Regional Heterogeneity in the Effect of Immigrants on Knowledge Inflow (OLS)

Table 10: Impact of Immigrant Share on Invention- and Utility-Type Patents

Table 11: Impact of Immigrant Share on External versus Self-Citations

Table 12: City covariates balance test

Table 13: Migrants flow covariates balance test

Table 14: Alternative Instrument

List of Figures

Figure 1: Fraction of Internal Migrants, 2010–2016

Figure 2: Fraction of Aggregated Immigrants in Cities, 2010

Figure 3: Mean Number of Migrants from Origin Provinces (2010–2016)

Figure 4: First-Stage Actual vs Predicted Immigration

## Mapping from code to output
Tables:

"summary_statistics.do" produces "Table 2: Summary Statistics" using  "city_panel.dta"

"first_stage.do" produces "Table 3: Instrument Relevance: First-Stage Regression of Immigrant Share on Shift-Share Instrument" using  "city_panel.dta"

"ols_and_2sls.do" produces "Table 4: OLS: The Effect of Immigrants on Knowledge Inflow" and "Table 5: 2SLS: The Effect of Immigrants on Knowledge Inflow" using  "city_panel.dta"

"high_skilled.do" produces "Table 6: The Effect of High-Skilled Immigrants on Knowledge Inflow" using  "city_panel.dta"

"recent.do" produces "Table 7: The Effect of Recent Immigrants on Knowledge Inflow" using  "city_panel.dta" 

"region.do" produces "Table 8: Regional Heterogeneity in the Effect of Immigrants on Knowledge Inflow (2SLS)" and "Table 9: Regional Heterogeneity in the Effect of Immigrants on Knowledge Inflow (OLS)" using  "city_panel.dta"

"invention_utility.do" produces "Table 10: Impact of Immigrant Share on Invention- and Utility-Type Patents" using "city_panel.dta"

"self.do" produces "Table 11: Impact of Immigrant Share on External versus Self-Citations" using "city_panel.dta"

"shock_balance.do" produces "Table 12: City covariates balance test" and "Table 13: Migrants flow covariates balance test" using "city_panel.dta"

"alternative_iv.do" produces "Table 14: Alternative Instrument" using "city_panel.dta"

Figures:

"summary_statistics.do" produces "Figure 1: Fraction of Internal Migrants, 2010–2016" using "national_total_immigrants_2011_17.dta"

"map.do" produces "Figure 2: Fraction of Aggregated Immigrants in Cities, 2010" using "city_panel.dta", "chinacity2020_coord.dta", "chinacity2020_label3", "chinacity2020_line_coord3.dta" and "polygon3""

"map.do" produces "Figure 3: Mean Number of Migrants from Origin Provinces (2010–2016)" using "city_panel.dta","chinaprov40_coord" and "chinaprov40_db.dta"

"first_stage.do" produces  "Figure 4: First-Stage Actual vs Predicted Immigration" using "city_panel.dta", "province panel transport quality.dta" and "weather shock.dta"

"pre_trend.do" produces "Figure 5: Effect of Fraction of Immigrants on Knowledge Inflow in Yearly Regression" using "city_panel.dta"



## Changes to the code to run locally
Change to your path in line 6 in “master.do” 

## Packages to install
Code runs in Stata 18. Packages not included in baseline distribution:

-ivreg2 

-reghdfe 

-ivreghdfe 

-ftools 

-outreg2 

-estout

-grmap

## How to run the code
Run “master.do”  in folder “Analysis” to execute all do-files.
