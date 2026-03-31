clear all
version 18
capture log close
*set maxvar 32767, permanently
********************************************************************************
*Project Title:  Making of Birth Record Dataset								   *
*Description:    															   *
*Dataset: Nepal Demographic Health Survey(NDHS)		  						   *
*Author: Ramesh Dulal 														   *
********************************************************************************
*==============================================================================*
*          		Final Dataset for Birth Record		                           *
* NOTE: All path globals ($data_2011_birth, $data_2016_birth, $data_2022_birth,*
*        $modified_data) are defined in Master.do. Run via Master.do only.     *
*------------------------------------------------------------------------------*

* Convenience alias so the rest of this file can use $data unchanged
global data "$modified_data"


**Using 2011 Survey Data

use "$data_2011_birth"

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

save "$data/2011_birth_gap.dta", replace


*Using Survey Data 2016

use "$data_2016_birth", clear

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
sort caseid

rename sdist district

order year caseid district, before (v000)

save "$data/2016_birth_gap.dta", replace


** Use the Dataset for 2022

use "$data_2022_birth", clear

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

gen year=2022
sort caseid

rename sdist district

order year caseid district, before (v000)

save "$data/2022_birth_gap.dta", replace


***Appending the Dataset***

use "$data/2011_birth_gap.dta", clear
append using "$data/2016_birth_gap.dta"
append using "$data/2022_birth_gap.dta"

save "$data/appended_birth_gap.dta", replace


*Keeping only Birth related variables
keep year caseid district bord_* b1_* b2_* b3_* b6_* m14_* m62_* m70_*  m66_* v005 v313 v190

drop b3_16 - b3_20
drop bord_16 - bord_20
drop b2_16 - b2_20
drop b1_16 - b1_20
drop b6_16 - b6_20

forvalues i=1/9 {
	rename bord_0`i' bord_`i'
	rename b3_0`i' b3_`i'
	rename b2_0`i' b2_`i'
	rename b1_0`i' b1_`i'
	rename b6_0`i' b6_`i'
}

/*
gen gap1_2 = b3_01 - b3_02
gen gap2_3 = b3_02 - b3_03
gen gap3_4 = b3_03 - b3_04
*/

forvalues i = 1/14 {
	local j = `i' + 1
	gen gap`i'_`j' = b3_`i' - b3_`j'
}

egen avg_birth_gap = rowmean (gap1_2 gap2_3 gap3_4 gap4_5 gap5_6 gap6_7 gap7_8 ///
gap8_9 gap9_10 gap10_11 gap11_12 gap12_13 gap13_14 gap14_15)

gen unique_id = _n
gen long mom_id = year * 100000 + unique_id

*creating ANC visit variables
egen ANC_visit = rowmax (m14_1 m14_2 m14_3 m14_4 m14_5 m14_6)
replace ANC_visit = 1 if ANC_visit > 0 & ANC_visit != .
replace ANC_visit = 0 if ANC_visit == 0
replace ANC_visit = . if missing(ANC_visit)
drop m14_*

*Creating PNC visit variables
egen resp_bef_disc = rowmax (m62_1 m62_2 m62_3 m62_4 m62_5 m62_6)
egen resp_after_disc = rowmax (m66_1 m66_2 m66_3 m66_4 m66_5 m66_6)
egen baby_pna_2mth = rowmax (m70_1 m70_2 m70_3 m70_4 m70_5 m70_6)
recode baby_pna_2mth (8=.)
drop m62_* m66_* m70_*

egen PNC_visit = rowmax (resp_after_disc resp_bef_disc  baby_pna_2mth)
drop resp_after_disc resp_bef_disc  baby_pna_2mth

egen use_health_service = rowmax (ANC_visit PNC_visit)

rename v313 contraceptive_use
recode contraceptive_use (3=1)(2=1)
label define contraceptive 1"Yes" 0"No"
label values contraceptive_use contraceptive

rename v190 wealth_index

reshape long bord_ b6_ b3_ b2_ b1_, i(mom_id) j(birth_order)

drop birth_order 
drop if b2_ == .

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

gen long kid_id = year * 100000 + unique_id

order kid_id, before(year)

drop birth_month birth_year b3_ dead_age unique_id mom_id

gen wt = v005/1000000

rename bord_ birth_order

tab birth_order, gen(birth_order_)

tab wealth_index, gen(wealth_index_)

collapse (sum)birth_order_* wealth_index_* use_health_service contraceptive_use (mean)gap* avg_birth_gap [pw=wt], by(district year_birth)

keep if year_birth >= 2010 
drop if year_birth >= 2020

save "$data/collapsed_birth_gap.dta", replace
