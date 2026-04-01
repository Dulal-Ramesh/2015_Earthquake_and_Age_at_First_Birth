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
*          		Final Dataset for Couple and Women Sample                      *
* NOTE: All path globals ($data_2011_women, $data_2016_women, $data_2022_women,*
*        $data_2011_couple, $data_2016_couple, $data_2022_couple,              *
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

save "$data/2011_women.dta", replace

//For Couple Data//

use "$data_2011_couple"

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

merge 1:1 caseid using "$data/2011_women.dta"
drop _merge

order year, after(caseid)

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

save "$data/women_couple_2011.dta", replace


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

save "$data/2016_women.dta", replace

//For Couple Dataset//

use "$data_2016_couple", clear

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

merge 1:1 caseid using "$data/2016_women.dta"
drop _merge

gen year=2016

order year, after(caseid)
rename sdist district

save "$data/women_couple_2016.dta", replace


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

save "$data/2022_women.dta", replace

//Using Couple Dataset//

use "$data_2022_couple", clear

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

merge 1:1 caseid using "$data/2022_women.dta",
drop _merge

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

save "$data/women_couple_2022.dta", replace


**Appending the three survey dataset into a single dataset**
use "$data/women_couple_2011.dta", clear

append using "$data/women_couple_2016.dta"

append using "$data/women_couple_2022.dta"

save "$data/women_couple_2011_16_22.dta", replace
