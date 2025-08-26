* this file input the city population
* very imporant element in computing migration share, ssiv and other

use "$folder/data/controls/CityYearBook.dta",clear 
keep 年份 城市 城市代码 户籍人口万人 年平均人口万人
rename 年份 year
rename 户籍人口万人 pop 
rename 城市代码 city_code
keep year pop city_code 
keep if year>2009 & year<2018
save "$folder/data/controls/city_pop.dta",replace