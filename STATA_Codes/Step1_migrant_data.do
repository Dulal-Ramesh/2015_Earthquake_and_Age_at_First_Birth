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
*          		Final Dataset for Migration		                               *
* NOTE: All path globals ($raw_data, $modified_data, $migrant_excel)           *
*        are defined in Master.do. Run via Master.do only.                     *
*------------------------------------------------------------------------------*

* Convenience aliases so the rest of this file can use $workdir unchanged
global workdir "$raw_data"

import excel using "$migrant_excel", sheet("District wise without individua") firstrow clear

label define lbl_district 1 "taplejung" 2 "panchthar" 3 "ilam" 4 "jhapa" 5 "morang" 6 "sunsari" 7 "dhankuta" 8 "terhathum" 9 "sankhuwasabha" ///
10 "bhojpur" 11 "solukhumbu" 12 "okhaldhunga" 13 "khotang" 14 "udayapur" 15 "saptari" 16 "siraha" 17 "dhanusa" 18 "mahotari" 19 "sarlahi" ///
20 "sindhuli" 21 "ramechhap" 22 "dolakha" 23 "sindhupalchowk" 24 "kavre" 25 "lalitpur" 26 "bhaktapur" 27 "kathmandu" 28 "nuwakot" 29 "rasuwa" ///
30 "dhading" 31 "makwanpur" 32 "rautahat" 33 "bara" 34 "parsa" 35 "chitwan" 36 "gorkha" 37 "lamjung" 38 "tanahu" 39 "syangja" 40 "kaski" ///
41 "manang" 42 "mustang" 43 "myagdi" 44 "parbat" 45 "baglung" 46 "gulmi" 47 "palpa" 48 "nawalparasi" 49 "rupandehi" 50 "kapilbastu" ///
51 "arghakhanchi" 52 "pyuthan" 53 "rolpa" 54 "rukum" 55 "salyan" 56 "dang" 57 "banke" 58 "bardiya" 59 "surkhet" 60 "dailekha" 61 "jajarkot" ///
62 "dolpa" 63 "jumla" 64 "kalikot" 65 "mugu" 66 "humla" 67 "bajura" 68 "bajhang" 69 "achham" 70 "doti" 71 "kailali" 72 "kanchanpur" ///
73 "dadeldhura" 74 "baitadi" 75 "darchula", replace

label values district lbl_district

save "$workdir/migration_agency.dta", replace


import excel using "$migrant_excel", sheet("District wise with individual") firstrow clear

label define lbl_district 1 "taplejung" 2 "panchthar" 3 "ilam" 4 "jhapa" 5 "morang" 6 "sunsari" 7 "dhankuta" 8 "terhathum" 9 "sankhuwasabha" ///
10 "bhojpur" 11 "solukhumbu" 12 "okhaldhunga" 13 "khotang" 14 "udayapur" 15 "saptari" 16 "siraha" 17 "dhanusa" 18 "mahotari" 19 "sarlahi" ///
20 "sindhuli" 21 "ramechhap" 22 "dolakha" 23 "sindhupalchowk" 24 "kavre" 25 "lalitpur" 26 "bhaktapur" 27 "kathmandu" 28 "nuwakot" 29 "rasuwa" ///
30 "dhading" 31 "makwanpur" 32 "rautahat" 33 "bara" 34 "parsa" 35 "chitwan" 36 "gorkha" 37 "lamjung" 38 "tanahu" 39 "syangja" 40 "kaski" ///
41 "manang" 42 "mustang" 43 "myagdi" 44 "parbat" 45 "baglung" 46 "gulmi" 47 "palpa" 48 "nawalparasi" 49 "rupandehi" 50 "kapilbastu" ///
51 "arghakhanchi" 52 "pyuthan" 53 "rolpa" 54 "rukum" 55 "salyan" 56 "dang" 57 "banke" 58 "bardiya" 59 "surkhet" 60 "dailekha" 61 "jajarkot" ///
62 "dolpa" 63 "jumla" 64 "kalikot" 65 "mugu" 66 "humla" 67 "bajura" 68 "bajhang" 69 "achham" 70 "doti" 71 "kailali" 72 "kanchanpur" ///
73 "dadeldhura" 74 "baitadi" 75 "darchula", replace

label values district lbl_district

merge 1:1 year_birth district using "$workdir/migration_agency.dta"
drop _merge

generate partner_migrant = ///
    (cond(missing(partner_agency), 0, partner_agency)) + ///
    (cond(missing(partner_individual), 0, partner_individual))

keep if year_birth >= 2010
drop if year_birth >= 2020

collapse (mean) partner_migrant, by(district year_birth)
save "$modified_data/male_migrant.dta", replace
