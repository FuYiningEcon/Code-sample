* this file computes the predicted population 

clear
* 1. compute growth rate
input int province_code str20 region ///
      y2009 y2010 y2011 y2012 y2013 y2014 y2015 y2016 y2017
11  "北京市"         1860 1962 2024 2078 2125 2171 2188 2195 2194
12  "天津市"         1228 1299 1341 1378 1410 1429 1439 1443 1410
13  "河北省"         7034 7194 7232 7262 7288 7323 7345 7375 7409
14  "山西省"         3427 3574 3562 3548 3535 3528 3519 3514 3510
15  "内蒙古自治区"   2458 2472 2470 2464 2455 2449 2440 2436 2433
21  "辽宁省"         4341 4375 4379 4375 4365 4358 4338 4327 4312
22  "吉林省"         2740 2747 2725 2698 2668 2642 2613 2567 2526
23  "黑龙江省"       3826 3833 3782 3724 3666 3608 3529 3463 3399
31  "上海市"         2210 2303 2356 2399 2448 2467 2458 2467 2466
32  "江苏省"         7810 7869 8023 8120 8192 8281 8315 8381 8423
33  "浙江省"         5276 5447 5570 5685 5784 5890 5985 6072 6170
34  "安徽省"         6131 5957 5972 5978 5988 5997 6011 6033 6057
35  "福建省"         3666 3693 3784 3841 3885 3945 3984 4016 4065
36  "江西省"         4432 4462 4474 4475 4476 4480 4485 4496 4511
37  "山东省"         9470 9588 9665 9708 9746 9808 9866 9973 10033
41  "河南省"         9487 9405 9461 9532 9573 9645 9701 9778 9829
42  "湖北省"         5720 5728 5760 5781 5798 5816 5850 5885 5904
43  "湖南省"         6406 6570 6581 6590 6600 6611 6615 6625 6633
44  "广东省"        10130 10441 10756 11041 11270 11489 11678 11908 12141
45  "广西壮族自治区" 4856 4610 4655 4694 4731 4770 4811 4857 4907
46  "海南省"          864  869  890  910  920  936  945  957  972
50  "重庆市"         2859 2885 2944 2975 3011 3043 3070 3110 3144
51  "四川省"         8185 8045 8064 8085 8109 8139 8196 8251 8289
52  "贵州省"         3537 3479 3530 3587 3632 3677 3708 3758 3803
53  "云南省"         4571 4602 4620 4631 4641 4653 4663 4677 4693
54  "西藏自治区"      296  300  309  315  317  325  330  340  349
61  "陕西省"         3727 3735 3765 3787 3804 3827 3846 3874 3904
62  "甘肃省"         2555 2560 2552 2550 2537 2531 2523 2520 2522
63  "青海省"          557  563  568  571  571  576  577  582  586
64  "宁夏回族自治区"   625  633  648  659  666  678  684  695  705
65  "新疆维吾尔自治区"2159 2185 2225 2253 2285 2325 2385 2428 2480
end //input population of provinces 

reshape long y, i(province_code region) j(year)
rename y prov_pop
drop region
tsset province_code year
gen growth_pop = (prov_pop - L.prov_pop) / L.prov_pop // \frac{pop^{-j}-pop_{t-1}}{pop_{t-1}^{-j}}
tempfile growth_pop1
save `growth_pop1'

* 2. merge city population and build the 2011 base
use "$folder/data/controls/city_pop.dta",clear
gen province_code=city_code
tostring province_code,replace
replace province_code=substr(province_code,1,2)
destring province_code,replace
merge m:1 year province_code using `growth_pop1'
keep if _merge==3
drop _merge
sort  city_code year
rename pop pop_actual
tsset city_code year
bysort city_code: gen pop_predict = pop*10000 if year==2011
bysort city_code: replace  pop_predict = L.pop_predict*(1+growth_pop) if missing(pop_predict)

keep year city_code pop_predict
label var pop_predict "Predicted population"
save "$folder/data/controls/predict_pop.dta",replace

