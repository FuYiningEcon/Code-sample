* this file contain clean for 2011-2017 waves of CMDS
* task is harmonising the disparate questionnaires of CMDS. (some definitions of variables are different in different waves)

use "$migration/2017.dta",clear

drop if q101l1==3 //migration to another county internal city

gen male=0
replace male=1 if q101b1==1 //male=1
gen birthy=q101c1y
generate eduy = 0
replace eduy = 6  if q101e1 == 2    // 小学 (6 years)
replace eduy = 9  if q101e1 == 3    // 初中 (6+3)
replace eduy = 12 if q101e1 == 4    // 高中/中专 (6+3+3)
replace eduy = 15 if q101e1 == 5    // 大学专科 (6+3+3+3)
replace eduy = 16 if q101e1 == 6    // 大学本科 (6+3+3+4)
replace eduy = 18 if q101e1 == 7    // 研究生 (6+3+3+4+2)
label variable eduy "Total years of education"
gen agriculture=0
replace agriculture=1 if q101f1==1
gen migyear=q101m1y
gen origin=substr(q101j1a,1,2)
destring origin,replace

replace C2="临夏回族自治州" if C2=="临夏州"
replace C2="克孜勒苏柯尔克孜自治州" if C2=="克孜勒苏柯尔克孜自治"
replace C2="凉山彝族自治州" if C2=="凉山州"
replace C2="博尔塔拉蒙古自治州" if C2=="博州"
replace C2="哈密市" if C2=="哈密地区"
replace C2="大理白族自治州" if C2=="大理州"
replace C2="延边朝鲜族自治州" if C2=="延边州"
replace C2="德宏傣族景颇族自治州" if C2=="德宏州"
replace C2="怒江傈僳族自治州" if C2=="怒江州"
replace C2="恩施土家族苗族自治州" if C2=="恩施州"
replace C2="文山壮族苗族自治州" if C2=="文山州"
replace C2="林芝市" if C2=="林芝地区"
replace C2="果洛藏族自治州" if C2=="果洛州"
replace C2="楚雄彝族自治州" if C2=="楚雄州"
replace C2="海北藏族自治州" if C2=="海北州"
replace C2="海南藏族自治州" if C2=="海南州"
replace C2="湘西土家族苗族自治州" if C2=="湘西州"
replace C2="玉树藏族自治州" if C2=="玉树州"
replace C2="甘孜藏族自治州" if C2=="甘孜州"
replace C2="红河哈尼族彝族自治州" if C2=="红河州"
replace C2="迪庆藏族自治州" if C2=="迪庆州"
replace C2="阿坝藏族羌族自治州" if C2=="阿坝州"
replace C2="黄南藏族自治州" if C2=="黄南州"
replace C2="黔东南苗族侗族自治州" if C2=="黔东南州苗族侗族自治"
replace C2="黔西南布依族苗族自治州" if C2=="黔西南州布依族苗族自"

replace C2="咸阳市" if C2=="杨凌示范区"
replace C2="佳木斯市" if C2=="抚远市"
replace C2="牡丹江市" if C2=="绥芬河市"

rename C2 city

merge m:1 city using "$folder/data/city.dta"
drop if _merge==2 
drop if city_code==.
drop _merge

gen year=2017
replace migyear=migyear-1 if migyear==year

keep city city_code year male eduy birthy migyear agriculture w_l origin

save "$migration/cmds2017.dta",replace

use "$migration/2016.dta",clear

drop if Q101L1==3

gen male=0
	replace male=1 if Q101B1==1 //male=1
generate eduy = 0
	replace eduy = 6  if Q101E1== 2    // 小学 (6 years)
	replace eduy = 9  if Q101E1== 3    // 初中 (6+3)
	replace eduy = 12 if Q101E1== 4    // 高中/中专 (6+3+3)
	replace eduy = 15 if Q101E1== 5    // 大学专科 (6+3+3+3)
	replace eduy = 16 if Q101E1== 6    // 大学本科 (6+3+3+4)
	replace eduy = 18 if Q101E1== 7    // 研究生 (6+3+3+4+2)
	label variable eduy "Total years of education"
gen agriculture=0
	replace agriculture=1 if Q101F1==1
gen migyear=Q101M1Y
gen birthy=Q101C1Y
gen origin=Q101J1

replace C2="黔西南布依族苗族自治州" if C2 == "黔西南布依族苗族自治"
replace C2="临夏回族自治州" if C2=="临夏州"
replace C2="凉山彝族自治州" if C2=="凉山州"
replace C2="哈密市" if C2=="哈密地区"
replace C2="大理白族自治州" if C2=="大理州"
replace C2="延边朝鲜族自治州" if C2=="延边州"
replace C2="德宏傣族景颇族自治州" if C2=="德宏州"
replace C2="怒江傈僳族自治州" if C2=="怒江州"
replace C2="恩施土家族苗族自治州" if C2=="恩施州"
replace C2="文山壮族苗族自治州" if C2=="文山州"
replace C2="林芝市" if C2=="林芝地区"
replace C2="果洛藏族自治州" if C2=="果洛州"
replace C2="楚雄彝族自治州" if C2=="楚雄州"
replace C2="海南藏族自治州" if C2=="海南州"
replace C2="湘西土家族苗族自治州" if C2=="湘西州"
replace C2="玉树藏族自治州" if C2=="玉树州"
replace C2="甘孜藏族自治州" if C2=="甘孜州"
replace C2="红河哈尼族彝族自治州" if C2=="红河州"
replace C2="迪庆藏族自治州" if C2=="迪庆州"
replace C2="阿坝藏族羌族自治州" if C2=="阿坝州"
replace C2="黄南藏族自治州" if C2=="黄南州"
replace C2="咸阳市" if C2=="杨凌示范区"
replace C2="福州市" if C2=="平潭综合实验区"
replace C2="牡丹江市" if C2=="绥芬河市（省直管县级"
replace C2="日喀则市" if C2=="日喀则地区"
replace C2="海西蒙古族藏族自治州" if C2=="海西州"
replace C2="甘南藏族自治州" if C2=="甘南州"
replace C2="红河哈尼族彝族自治州" if C2=="红河州"
replace C2="红河哈尼族彝族自治州" if C2=="红河洲"


rename C2 city

merge m:1 city using "$folder/data/city.dta"
drop if _merge==2 
drop if city_code==.
drop _merge

gen year=2016
keep city city_code year male eduy birthy migyear agriculture w_l origin
replace migyear=migyear-1 if migyear==year

save "$migration/cmds2016.dta",replace

use "$migration/2015.dta",clear

drop if q101j1==3

gen male=0
	replace male=1 if q101b1==1 //male=1
generate eduy = 0
	replace eduy = 6  if q101e1== 2    // 小学 (6 years)
	replace eduy = 9  if q101e1== 3    // 初中 (6+3)
	replace eduy = 12 if q101e1== 4    // 高中/中专 (6+3+3)
	replace eduy = 15 if q101e1== 5    // 大学专科 (6+3+3+3)
	replace eduy = 16 if q101e1== 6    // 大学本科 (6+3+3+4)
	replace eduy = 18 if q101e1== 7    // 研究生 (6+3+3+4+2)
	label variable eduy "Total years of education"
gen agriculture=0
	replace agriculture=1 if q101f1==1
gen migyear=q101k1y
gen birthy=q101c1y
gen origin= q101h1

replace F2="巴音郭楞蒙古自治州" if F2=="巴音郭楞蒙古族自治州"
replace F2="巴音郭楞蒙古自治州" if F2=="巴音郭勒蒙古自治州"
replace F2="临夏回族自治州" if F2=="临夏州"
replace F2="临夏回族自治州" if F2=="临夏市"
replace F2="克孜勒苏柯尔克孜自治州" if F2=="克孜勒苏柯尔克孜自治"
replace F2="凉山彝族自治州" if F2=="凉山州"
replace F2="博尔塔拉蒙古自治州" if F2=="博州"
replace F2="哈密市" if F2=="哈密地区"
replace F2="大理白族自治州" if F2=="大理州"
replace F2="延边朝鲜族自治州" if F2=="延边州"
replace F2="德宏傣族景颇族自治州" if F2=="德宏州"
replace F2="怒江傈僳族自治州" if F2=="怒江州"
replace F2="恩施土家族苗族自治州" if F2=="恩施州"
replace F2="文山壮族苗族自治州" if F2=="文山州"
replace F2="林芝市" if F2=="林芝地区"
replace F2="果洛藏族自治州" if F2=="果洛州"
replace F2="楚雄彝族自治州" if F2=="楚雄州"
replace F2="海北藏族自治州" if F2=="海北州"
replace F2="海南藏族自治州" if F2=="海南州"
replace F2="湘西土家族苗族自治州" if F2=="湘西州"
replace F2="玉树藏族自治州" if F2=="玉树州"
replace F2="甘孜藏族自治州" if F2=="甘孜州"
replace F2="红河哈尼族彝族自治州" if F2=="红河州"
replace F2="迪庆藏族自治州" if F2=="迪庆州"
replace F2="阿坝藏族羌族自治州" if F2=="阿坝州"
replace F2="黄南藏族自治州" if F2=="黄南州"
replace F2="黔东南苗族侗族自治州" if F2=="黔东南"
replace F2="黔东南苗族侗族自治州" if F2=="黔东南州"
replace F2="西双版纳傣族自治州" if F2=="西双版纳州"
replace F2="黔西南布依族苗族自治州" if F2=="黔西南州"
replace F2="福州市" if F2=="平潭综合实验区"
replace F2="海西蒙古族藏族自治州" if F2=="海西州"
replace F2="甘南藏族自治州" if F2=="甘南州"
replace F2="咸阳市" if F2=="杨凌示范区"
replace F2="神农架林区" if F2=="神农架"
replace F2="吐鲁番市" if F2=="吐鲁番地区"
replace F2="大兴安岭地区" if F2=="大兴安岭"
replace F2="伊犁哈萨克自治州" if F2=="伊犁州"
replace F2="昌吉回族自治州" if F2=="昌吉州"
replace F2="黔南布依族苗族自治州" if F2=="黔南州"
replace F2="牡丹江市" if F2=="省直管县"

rename F2 city

merge m:1 city using "$folder/data/city.dta"
replace city_code=469000 if city=="省直辖"
drop if _merge==2 
drop if city_code==.
drop _merge

gen year=2015
keep city city_code year male eduy birthy migyear agriculture w_l origin
replace migyear=migyear-1 if migyear==year

save "$migration/cmds2015.dta",replace

use "$migration/2014.dta",clear

rename city_name city
drop if flo_rage_1==3


gen male=0
	replace male=1 if gender_1==1 //male=1
generate eduy = 0
	replace eduy = 6  if edu_stat_1== 2    // 小学 (6 years)
	replace eduy = 9  if edu_stat_1== 3    // 初中 (6+3)
	replace eduy = 12 if edu_stat_1== 4    // 高中/中专 (6+3+3)
	replace eduy = 15 if edu_stat_1== 5    // 大学专科 (6+3+3+3)
	replace eduy = 16 if edu_stat_1== 6    // 大学本科 (6+3+3+4)
	replace eduy = 18 if edu_stat_1== 7    // 研究生 (6+3+3+4+2)
	label variable eduy "Total years of education"
gen agriculture=0
	replace agriculture=1 if acc_nat_1==1
gen migyear=floyear_1
gen birthy=birt_y_1
gen origin=resi_place_1

gen city_code=substr(inte_code,1,4)
destring city_code,replace
replace city_code=city_code*100
replace city_code=110000 if city_code==110100
drop if city_code==110200
replace city_code=120000 if city_code==120100
drop if city_code==120200
replace city_code=310000 if city_code==310100
drop if  city_code==310200
replace city_code=500000 if city_code==500100
drop if city_code==500200
drop if city_code==.
gen year=2014

keep city city_code year male eduy birthy migyear agriculture w_l origin
replace migyear=migyear-1 if migyear==year

save "$migration/cmds2014.dta",replace

use "$migration/2013.dta",clear
rename city_name city
drop if flo_rage_1==3

gen male=0
	replace male=1 if gender_1==1 //male=1
generate eduy = 0
	replace eduy = 6   if edu_status_1 == 2    // 小学 (6 years)
	replace eduy = 9   if edu_status_1 == 3    // 初中 (6+3)
	replace eduy = 12  if edu_status_1 == 4    // 高中 (6+3+3)
	replace eduy = 12  if edu_status_1 == 5    // 中专 (6+3+3)
	replace eduy = 15  if edu_status_1 == 6    // 大学专科 (6+3+3+3)
	replace eduy = 16  if edu_status_1 == 7    // 大学本科 (6+3+3+4)
	replace eduy = 18  if edu_status_1 == 8    // 研究生 (6+3+3+4+2)
	label variable eduy "Total years of education"
gen agriculture=0
	replace agriculture=1 if acc_nature_1==1
gen migyear=floyear_1
gen birthy=birt_y_1
gen origin=resi_place_1

tostring inte_code,replace
gen city_code=substr(inte_code,1,4)
destring city_code,replace
replace city_code=city_code*100
replace city_code=110000 if city_code==110100
drop if city_code==110200
replace city_code=120000 if city_code==120100
drop if city_code==120200
replace city_code=310000 if city_code==310100
drop if  city_code==310200
replace city_code=500000 if city_code==500100
drop if city_code==500200

gen year=2013

keep city city_code year male eduy birthy migyear agriculture w_l origin
replace migyear=migyear-1 if migyear==year

save "$migration/cmds2013.dta",replace

use "$migration/2012.dta",clear
rename city_name city
drop if flo_rage_1==3

gen male=0
	replace male=1 if gender_1==1 //male=1
generate eduy = 0 
	replace eduy = 6   if edu_status_1 == 2    // 小学 (6 years)
	replace eduy = 9   if edu_status_1 == 3    // 初中 (6+3)
	replace eduy = 12  if edu_status_1 == 4    // 高中 (6+3+3)
	replace eduy = 12  if edu_status_1 == 5    // 中专 (6+3+3)
	replace eduy = 15  if edu_status_1 == 6    // 大学专科 (6+3+3+3)
	replace eduy = 16  if edu_status_1 == 7    // 大学本科 (6+3+3+4)
	replace eduy = 18  if edu_status_1 == 8    // 研究生 (6+3+3+4+2)
	label variable eduy "Total years of education"
gen agriculture=0
	replace agriculture=1 if acc_nature_1==1
gen migyear=flo_time_1
tostring birt_date_1,replace
gen birthy=substr(birt_date_1,1,4)
destring birthy,replace
gen origin=resi_place_1

tostring inte_code,replace
gen city_code=substr(inte_code,1,4)
destring city_code,replace
replace city_code=city_code*100
replace city_code=110000 if city_code==110100
drop if city_code==110200
replace city_code=120000 if city_code==120100
drop if city_code==120200
replace city_code=310000 if city_code==310100
drop if  city_code==310200
replace city_code=500000 if city_code==500100
drop if city_code==500200

gen year=2012
keep city city_code year male eduy birthy migyear agriculture w_l origin
replace migyear=migyear-1 if migyear==year

save "$migration/cmds2012.dta",replace

use "$migration/2011.dta",clear

drop if q101i1==3
drop if q101i1==4

gen male=0
	replace male=1 if q101b1==1 //male=1
generate eduy = 0
	replace eduy = 6   if q101g2 == 2    // 小学 (6 years)
	replace eduy = 9   if q101g2 == 3    // 初中 (6+3)
	replace eduy = 12  if q101g2 == 4    // 高中 (6+3+3)
	replace eduy = 12  if q101g2 == 5    // 中专 (6+3+3)
	replace eduy = 15  if q101g2 == 6    // 大学专科 (6+3+3+3)
	replace eduy = 16  if q101g2 == 7    // 大学本科 (6+3+3+4)
	replace eduy = 18  if q101g2 == 8    // 研究生 (6+3+3+4+2)
	label variable eduy "Total years of education"
gen agriculture=0
	replace agriculture=1 if q101h2==1
tostring q101j1, replace
gen migyear=substr(q101j1, 1, 4)
destring migyear,replace
tostring q101c1, replace
gen birthy=substr(q101c1, 1, 4)
destring birthy,replace
gen origin=q101e1

replace city = trim(city)
replace city="临夏回族自治州" if city=="临夏州"
replace city="克孜勒苏柯尔克孜自治州" if city=="克孜勒苏柯尔克孜自治"
replace city="凉山彝族自治州" if city=="凉山州"
replace city="博尔塔拉蒙古自治州" if city=="博州"
replace city="哈密市" if city=="哈密地区"
replace city="大理白族自治州" if city=="大理州"
replace city="延边朝鲜族自治州" if city=="延边州"
replace city="德宏傣族景颇族自治州" if city=="德宏州"
replace city="怒江傈僳族自治州" if city=="怒江州"
replace city="恩施土家族苗族自治州" if city=="恩施州"
replace city="文山壮族苗族自治州" if city=="文山州"
replace city="林芝市" if city=="林芝地区"
replace city="果洛藏族自治州" if city=="果洛州"
replace city="楚雄彝族自治州" if city=="楚雄州"
replace city="海北藏族自治州" if city=="海北州"
replace city="海南藏族自治州" if city=="海南州"
replace city="湘西土家族苗族自治州" if city=="湘西州"
replace city="玉树藏族自治州" if city=="玉树州"
replace city="甘孜藏族自治州" if city=="甘孜州"
replace city="红河哈尼族彝族自治州" if city=="红河州"
replace city="迪庆藏族自治州" if city=="迪庆州"
replace city="阿坝藏族羌族自治州" if city=="阿坝州"
replace city="黄南藏族自治州" if city=="黄南州"
replace city="黔东南苗族侗族自治州" if city=="黔东南州苗族侗族自治"
replace city="黔东南苗族侗族自治州" if city=="黔南州"
replace city="黔西南布依族苗族自治州" if city=="黔西南州"
replace city="黔西南布依族苗族自治州" if city=="黔西南州布依族苗族自"
replace city="吐鲁番市" if city=="吐鲁番地区"
replace city="毕节市" if city=="毕节地区"
replace city="海东市" if city=="海东地区"
replace city="甘南藏族自治州" if city=="甘南州"
replace city="西双版纳傣族自治州" if city=="西双版纳州"
replace city="铜仁市" if city=="铜仁地区"
replace city="六盘水市" if city=="六盘水"
replace city="呼和浩特市" if city=="呼和浩特"
replace city="咸阳市" if city=="杨凌示范区"


merge m:1 city using "$folder/data/city.dta"
replace city_code=371200 if city=="莱芜市"
drop if _merge==2 
drop if city_code==.
drop _merge
gen year=2011
keep city city_code year male eduy birthy migyear agriculture w_l origin
replace migyear=migyear-1 if migyear==year

save "$migration/cmds2011.dta",replace

use "$migration/cmds2011.dta",clear
append using  "$migration/cmds2017.dta"
append using  "$migration/cmds2016.dta"
append using  "$migration/cmds2015.dta"
append using  "$migration/cmds2014.dta"
append using  "$migration/cmds2013.dta"
append using  "$migration/cmds2012.dta"

cap erase  "$migration/cmds2017.dta"
cap erase  "$migration/cmds2016.dta"
cap erase  "$migration/cmds2015.dta"
cap erase  "$migration/cmds2014.dta"
cap erase  "$migration/cmds2013.dta"
cap erase  "$migration/cmds2012.dta"
cap erase  "$migration/cmds2011.dta"

replace year=year-1

save "$migration/demography",replace