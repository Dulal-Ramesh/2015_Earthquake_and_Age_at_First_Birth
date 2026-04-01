clear all
version 18
capture log close
*set maxvar 32767, permanently
********************************************************************************
*Project Title:  Making of Breastfeeding Dataset							   *
*Description:    															   *
*Dataset: Nepal Demographic Health Survey(NDHS)		  						   *
*Author: Ramesh Dulal 														   *
********************************************************************************
*==============================================================================*
*          		Final Dataset for Breastfeeding                                *
* NOTE: All path globals ($data_2011_women, $data_2016_women, $data_2022_women,*
*        $modified_data) are defined in Master.do. Run via Master.do only.     *
*------------------------------------------------------------------------------*

* Convenience alias so the rest of this file can use $data unchanged
global data "$modified_data"


**Using 2011 Survey Data
//For Women
use "$data_2011_women"

label define lbl_district 1 "taplejung" 2 "panchthar" 3 "ilam" 4 "jhapa" 5 "morang" 6 "sunsari" 7 "dhankuta" 8 "terhathum" 9 "sankhuwasabha" ///
10 "bhojpur" 11 "solukhumbu" 12 "okhaldhunga" 13 "khotang" 14 "udayapur" 15 "saptari" 16 "siraha" 17 "dhanusa" 18 "mahotari" 19 "sarlahi" ///
20 "sindhuli" 21 "ramechhap" 22 "dolakha" 23 "sindhupalchowk" 24 "kavre" 25 "lalitpur" 26 "bhaktapur" 27 "kathmandu" 28 "nuwakot" 29 "rasuwa" ///
30 "dhading" 31 "makwanpur" 32 "rautahat" 33 "bara" 34 "parsa" 35 "chitwan" 36 "gorkha" 37 "lamjung" 38 "tanahu" 39 "syangja" 40 "kaski" ///
41 "manang" 42 "mustang" 43 "myagdi" 44 "parbat" 45 "baglung" 46 "gulmi" 47 "palpa" 48 "nawalparasi" 49 "rupandehi" 50 "kapilbastu" ///
51 "arghakhanchi" 52 "pyuthan" 53 "rolpa" 54 "rukum" 55 "salyan" 56 "dang" 57 "banke" 58 "bardiya" 59 "surkhet" 60 "dailekha" 61 "jajarkot" ///
62 "dolpa" 63 "jumla" 64 "kalikot" 65 "mugu" 66 "humla" 67 "bajura" 68 "bajhang" 69 "achham" 70 "doti" 71 "kailali" 72 "kanchanpur" ///
73 "dadeldhura" 74 "baitadi" 75 "darchula", replace

label values sdist lbl_district

gen year=2011
sort caseid

rename sdist district

order year caseid district, before (v000)


// Loop through the range from 01 to 20
forvalues i = 1/20 {
    local suffix: display %02.0f `i'
    rename s227_`suffix' s220ap_`suffix'
}

forvalues i = 1/20 {
    local suffix: display %02.0f `i'
    rename s226y_`suffix' s215y_`suffix'
}

forvalues i = 1/20 {
    local suffix: display %02.0f `i'
    rename s226m_`suffix' s215m_`suffix'
}

save "$data/2011_women_breastfeed.dta", replace


*Using Survey Data 2016
//For Women Dataset//

use "$data_2016_women", clear
sort caseid

label define lbl_district 1 "taplejung" 2 "panchthar" 3 "ilam" 4 "jhapa" 5 "morang" 6 "sunsari" 7 "dhankuta" 8 "terhathum" 9 "sankhuwasabha" ///
10 "bhojpur" 11 "solukhumbu" 12 "okhaldhunga" 13 "khotang" 14 "udayapur" 15 "saptari" 16 "siraha" 17 "dhanusa" 18 "mahotari" 19 "sarlahi" ///
20 "sindhuli" 21 "ramechhap" 22 "dolakha" 23 "sindhupalchowk" 24 "kavre" 25 "lalitpur" 26 "bhaktapur" 27 "kathmandu" 28 "nuwakot" 29 "rasuwa" ///
30 "dhading" 31 "makwanpur" 32 "rautahat" 33 "bara" 34 "parsa" 35 "chitwan" 36 "gorkha" 37 "lamjung" 38 "tanahu" 39 "syangja" 40 "kaski" ///
41 "manang" 42 "mustang" 43 "myagdi" 44 "parbat" 45 "baglung" 46 "gulmi" 47 "palpa" 48 "nawalparasi" 49 "rupandehi" 50 "kapilbastu" ///
51 "arghakhanchi" 52 "pyuthan" 53 "rolpa" 54 "rukum" 55 "salyan" 56 "dang" 57 "banke" 58 "bardiya" 59 "surkhet" 60 "dailekha" 61 "jajarkot" ///
62 "dolpa" 63 "jumla" 64 "kalikot" 65 "mugu" 66 "humla" 67 "bajura" 68 "bajhang" 69 "achham" 70 "doti" 71 "kailali" 72 "kanchanpur" ///
73 "dadeldhura" 74 "baitadi" 75 "darchula", replace

label values sdist lbl_district

gen year=2016

order year, after(caseid)
rename sdist district

save "$data/2016_women_breastfeed.dta", replace


** Use the Dataset for 2022
//For Women Dataset//
use "$data_2022_women", clear

sort caseid
recode sdist (707=69) (505=51) (411=45) (704=74) (702=68) (701=67) (511=57) (207=33) (512=58) (307=26) (106=10) (313=35) (705=73) (606=60) (510=56) (703=75) (304=30) (107=7) (203=17) (301=22) (601=62) (706=70) (401=36) (504=46) (603=66) (110=3) (607=61) (111=4) (604=63) (708=71) (605=64) (709=72) (509=50) (405=40) (306=27) (309=24) (105=13) (308=25) (406=37) (204=18) (312=31) (402=41) (112=5) (602=65) (403=42) (404=43) (408=48) (507=48) (305=28) (104=12) (506=47) (109=2) (410=44) (208=34) (503=52) (310=21) (303=29) (206=32) (502=53) (501=54) (608=54) (508=49) (609=55) (102=9) (201=15) (205=19) (311=20) (302=23) (202=16) (103=11) (113=6) (610=59) (409=39) (407=38) (101=1) (108=8) (114=14)

label define lbl_district 1 "taplejung" 2 "panchthar" 3 "ilam" 4 "jhapa" 5 "morang" 6 "sunsari" 7 "dhankuta" 8 "terhathum" 9 "sankhuwasabha" ///
10 "bhojpur" 11 "solukhumbu" 12 "okhaldhunga" 13 "khotang" 14 "udayapur" 15 "saptari" 16 "siraha" 17 "dhanusa" 18 "mahotari" 19 "sarlahi" ///
20 "sindhuli" 21 "ramechhap" 22 "dolakha" 23 "sindhupalchowk" 24 "kavre" 25 "lalitpur" 26 "bhaktapur" 27 "kathmandu" 28 "nuwakot" 29 "rasuwa" ///
30 "dhading" 31 "makwanpur" 32 "rautahat" 33 "bara" 34 "parsa" 35 "chitwan" 36 "gorkha" 37 "lamjung" 38 "tanahu" 39 "syangja" 40 "kaski" ///
41 "manang" 42 "mustang" 43 "myagdi" 44 "parbat" 45 "baglung" 46 "gulmi" 47 "palpa" 48 "nawalparasi" 49 "rupandehi" 50 "kapilbastu" ///
51 "arghakhanchi" 52 "pyuthan" 53 "rolpa" 54 "rukum" 55 "salyan" 56 "dang" 57 "banke" 58 "bardiya" 59 "surkhet" 60 "dailekha" 61 "jajarkot" ///
62 "dolpa" 63 "jumla" 64 "kalikot" 65 "mugu" 66 "humla" 67 "bajura" 68 "bajhang" 69 "achham" 70 "doti" 71 "kailali" 72 "kanchanpur" ///
73 "dadeldhura" 74 "baitadi" 75 "darchula", replace

label values sdist lbl_district

forvalues i = 1/20 {
    local suffix: display %02.0f `i'
    rename pidxb_`suffix' pidx97_`suffix'
}

forvalues i = 1/20 {
    local suffix: display %02.0f `i'
    rename pord_`suffix' pord97_`suffix'
}

forvalues i = 1/20 {
    local suffix: display %02.0f `i'
    rename p1_`suffix' s215m_`suffix'
}

forvalues i = 1/20 {
    local suffix: display %02.0f `i'
    rename p2_`suffix' s215y_`suffix'
}

forvalues i = 1/20 {
    local suffix: display %02.0f `i'
    rename p20_`suffix' s220ap_`suffix'
}

forvalues i = 1/20 {
    local suffix: display %02.0f `i'
    rename p32_`suffix' sprego_`suffix'
}

gen year=2022

order year, after(caseid)
rename sdist district

save "$data/2022_women_breastfeed.dta", replace


**Appending the three survey dataset into a single dataset**
use "$data/2011_women_breastfeed.dta", clear
append using "$data/2016_women_breastfeed.dta"
append using "$data/2022_women_breastfeed.dta"

keep year caseid district v005 v021 v022 v023 bidx_* bord_* b0_* b1_* b2_* b3_* b4_* b5_* b6_* b7_* b8_* b9_*  m4_* m5_*

forvalue i=1/9 {
	rename bidx_0`i' bidx_`i'
	rename bord_0`i' bord_`i'
	rename b0_0`i' b0_`i'
	rename b1_0`i' b1_`i'
	rename b2_0`i' b2_`i'
	rename b3_0`i' b3_`i'
	rename b4_0`i' b4_`i'
	rename b5_0`i' b5_`i'
	rename b6_0`i' b6_`i'
	rename b7_0`i' b7_`i'
	rename b8_0`i' b8_`i'
	rename b9_0`i' b9_`i'
}

forvalue i = 7/20 {
	drop b*_`i'
}

drop b*_6
drop m*_6

gen unique_id = _n
gen long mom_id = year * 100000 + unique_id

drop unique_id
order mom_id, before (year)

reshape long bidx_ bord_ b0_ b1_ b2_ b3_ b4_ b5_ b6_ b7_ b8_ b9_ m4_ m5_, i(mom_id) j(birth_order)

drop if bidx_ == .

gen unique_id = _n
gen long kid_id = year * 100000 + unique_id
drop mom_id unique_id birth_order
order kid_id, before(year)

gen wt = v005/1000000

rename b2_ birth_year
rename b1_ birth_month
rename b6_ dead_age

gen year_birth= birth_year-57
order year_birth, after(birth_year)
label var year_birth "Birth Year in English Calendar"
label var birth_year "Birth Year in Nepali Calendar"

drop if year_birth<2004
drop if year_birth>=2020
drop if year_birth==2019 & birth_month>10
drop if year_birth==2019 & birth_month==10 & dead_age>108 

gen breastfed = 0
replace breastfed = 1 if m4_ != 94

rename m5_ month_breastfed

replace month_breastfed = . if month_breastfed == 93 
replace month_breastfed = . if month_breastfed == 94

keep if year_birth >= 2010 
drop if year_birth >= 2020

tab bord_, gen(birth_order_)

** Assigning the month of breastfeeding for specific order of the child ****

forvalues i = 1/15{
	gen month_bf_order`i' = month_breastfed if birth_order_`i' == 1
}

collapse (sum) birth_order_* breastfed (mean) month_breastfed month_bf_order* [pw = wt], by(district year_birth) 

save "$data/women_breastfeed_2011_16_22.dta", replace
