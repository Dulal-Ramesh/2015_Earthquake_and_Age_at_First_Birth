clear all
version 18
capture log close
*set maxvar 32767, permanently
********************************************************************************
*Project Title:  															   *
*Description:    															   *
*Dataset: Nepal Demographic Health Survey(NDHS)		  						   *
*Author: Ramesh Dulal 														   *
********************************************************************************
*==============================================================================*
*	Setting up the variables from Women and Couple combined Dataset            *
* NOTE: All path globals ($modified_data) are defined in Master.do.           *
*       Run via Master.do only.                                                *
*------------------------------------------------------------------------------*

* Convenience alias so the rest of this file can use $workdir unchanged
global workdir "$modified_data"


use "$workdir/women_couple_2011_16_22.dta", clear

gen mothers_id=_n
order mothers_id, before(caseid)
order district, after(year)


keep mothers_id caseid year district v005 v021 v022 v023 v511 bidx_* bord_* b0_* b1_* b2_* ///
b3_* b4_* b5_* b6_* b7_* b8_* b9_* b10_* b11_* b12_* b13_* b15_* b16_* pidx97_* pord97_* s215m_* s215y_* s220ap_* sprego_* hw70_* hw71_* hw72_* hw73_* d102 d104 d106 d107 d108 d127a d127b d127c d127d d127e d127f d127g d127h d115b d115c d115d d115f d115g d115j d115k d115l d115o d115p d115q d118a d118b d118c d118d d118f d118g d118j d118k d118l d118o d118p d118q v012 v013 v201 v212 v503 v531 v714 v716 v732 v741 v171a v171b v169a v131 v130 v157 v158 v159 v106 v133 v463z v483a mv012 mv013 mv131 mv133 mv157 mv158 mv159 mv167 mv168 mv212 mv463z mv716 mv732 mv169a mv171a mv171b mv106 mv107 mv503 mv714 v115 v120 v121 v123 v124 v125 v153 mv130 mv201 mv155 v155 mv531 mv741 v504 v730 v701 v704



forvalue i=1/9 {
	rename bidx_0`i' bidx_`i'
	rename bord_0`i' bord_`i'
	rename b1_0`i' b1_`i'
	rename b2_0`i' b2_`i'
	rename b3_0`i' b3_`i'
	rename b4_0`i' b4_`i'
	rename b5_0`i' b5_`i'
	rename b6_0`i' b6_`i'
	rename b7_0`i' b7_`i'
	rename pidx97_0`i' pidx97_`i' 
	rename pord97_0`i' pord97_`i'
	rename s215m_0`i' s215m_`i'
	rename s215y_0`i' s215y_`i'
	rename s220ap_0`i' s220ap_`i'
	rename sprego_0`i' sprego_`i'
}

drop bidx_16-bidx_20
drop bord_16-bord_20
drop b0_16 - b0_20 
drop b1_16-b1_20
drop b2_16-b2_20
drop b3_16 - b3_20 
drop b4_16-b4_20
drop b5_16-b5_20
drop b6_16-b6_20
drop b7_16-b7_20
drop b8_16 - b8_20 
drop b9_16 - b9_20
drop b10_16 - b10_20
drop b11_16 - b11_20
drop b12_16 - b12_20
drop b13_16 - b13_20
drop b15_16 - b15_20
drop b16_16 - b16_20

drop sprego_19 sprego_20 sprego_21 sprego_22 sprego_23 sprego_24 s220ap_19 s220ap_20 s220ap_21 s220ap_22 s220ap_23 s220ap_24  s215y_19 s215y_20 s215y_21 s215y_22 s215y_23 s215y_24 s215m_19 s215m_20 s215m_21 s215m_22 s215m_23 s215m_24 pord97_19 pord97_20 pord97_21 pord97_22 pord97_23 pord97_24 pidx97_19 pidx97_20 pidx97_21 pidx97_22 pidx97_23 pidx97_24

drop b0_* b10_* b11_* b12_* b13_* b15_* b16_*  b8_* b9_*         

reshape long bidx_ bord_ b1_ b2_ b3_ b4_ b5_ b6_ b7_ pidx97_ pord97_ s215m_ s215y_ s220ap_ sprego_ hw70_ hw71_ hw72_ hw73_, i(mothers_id) j(birth_order)

save "$workdir/reshaped_data.dta", replace


use "$workdir/reshaped_data", clear
drop birth_order 

rename bord_ birth_order
rename b1_ birth_month
rename b2_ birth_year
rename b3_ birth_month_cmc
rename b4_ sex_child
rename b5_ dead_alive
rename b6_ dead_age
rename b7_ age_at_death
rename pidx97_ pregnancy_index
rename pord97_ pregnancy_order
rename s215m_ pregnancy_end_month
rename s215y_ pregnancy_end_year
rename s220ap_ pregnancy_duration
rename sprego_ pregnancy_outcome
rename hw70_ height_age_sd
rename hw71_ weight_age_sd
rename hw72_ weight_height_sd
rename hw73_ bmi_sd


gen live_birth = 0
replace live_birth = 1 if pregnancy_outcome == 1
gen still_birth = 0
replace still_birth = 1 if pregnancy_outcome == 2

gen miscarriage = 0
replace miscarriage = 1 if pregnancy_outcome == 3

gen abortion = 0
replace abortion = 1 if pregnancy_outcome == 4

gen neonatal_death = 0
replace neonatal_death = 1 if dead_age < 201

gen year_birth= birth_year-57
order year_birth, after(birth_year)
label var year_birth "Birth Year in English Calendar"
label var birth_year "Birth Year in Nepali Calendar"

gen year_of_death=year_birth + age_at_death/12
label var year_of_death "Year of Death"
order year_of_death, after(year_birth)

recode sex_child (1=0)(2=1)
label define sex_child 1"Female" 0"Male"
label values sex_child sex_child



drop if year_birth<2004
drop if year_birth>=2020
drop if year_birth==2019 & birth_month>10

drop if year_birth==2019 & birth_month==10 & dead_age>108 ///drop the observations if the age of death of the child is more than 2020 January. Since the first case of covid was seen in Nepal in 2020 January 23.///

drop birth_year

//Domestic Violence related variables//

gen control_issues=0
replace control_issues=1 if d102>0 & d102<.
label var control_issues "Control by Partner"

gen emotional_violence=0
replace emotional_violence=1 if d104>0 & d104<.
label var emotional_violence "Emotional Violence by Partner"

rename d106 low_severe_violence 
label var low_severe_violence "Low Severe Physical Violence by Partner"

rename d107 severe_violence
label var severe_violence "Severe Physical Violence by Partner"


gen sexual_violence=0
replace sexual_violence=1 if d108==1 | d127a==1 | d127b==1 | d127c==1 | d127d==1 | d127e==1 | d127f==1 | d127g==1 | d127h==1
label var sexual_violence "Sexual Violence by Partner"
label define sex_violence 1 "Yes" 0 "No"
label values sexual_violence sex_violence



gen physical_violence_other=0
replace physical_violence_other=1 if d115b==1 | d115c==1 | d115d==1 | d115f==1 | d115g==1 | d115j==1 | d115k==1 | d115l==1 | d115o==1 | d115p==1 | d115q==1
label var physical_violence_other "Physical Violence by Other than Partner"

gen domestic_violence=0
replace domestic_violence=1 if emotional_violence==1 | low_severe_violence==1 | severe_violence==1 | sexual_violence==1 | physical_violence_other==1
label var domestic_violence "Domestic Violence"
label define domestic_violence 1 "Yes" 0 "No", replace
label values domestic_violence domestic_violence


gen pregnancy_violence=0
replace pregnancy_violence=1 if d118a==1 | d118b==1 | d118c==1 | d118d==1 | d118f==1 | d118g==1 | d118j==1 | d118k==1 | d118l==1 | d118o==1 | d118p==1 | d118q==1
label var pregnancy_violence "Violence during Pregnancy"
label define preg_violence 1 "Yes" 0 "No"
label values pregnancy_violence preg_violence

rename  v012 mothers_age
label var mothers_age "Mother's Age"
rename v013 mothers_age_group
rename  v201 tot_children_mother 
label var tot_children_mother "Total Number of Children"
rename  v212 age_first_birth_mother 
label var age_first_birth_mother "Age at First Birth"
*rename  v440 height_age_sd 
*rename  v444a weight_height_sd 
*rename  v445 bmi 
*rename  v453 haemoglobin 
*rename  v457 anemia 
rename  v503 num_union_mother 
label var num_union_mother "Number of Union (Mother)"
rename  v531 age_first_sex_mother 
label var age_first_sex_mother "Age at First Sex (Mother)"
rename  v714 mother_working
label var mother_working "Mother Currently Working" 
rename  v716 occupation_mother 
rename  v732 employed_annual_mother 
rename  v741 earning_type_mother 
rename  v171a use_internet_mother 
rename  v171b frequency_internet_mother 
rename  v169a mother_owns_mobile 
rename  v131 ethnicity_mother 
rename v511 marriage_age

rename  v130 religion_mother 
recode religion_mother (2/5 = 0) (96 = 0) 
label define v130 0 "Non-Hindu" 1 "Hindu", modify

rename  v157 frequency_news_mother 
rename  v158 frequency_radio_mother 
rename  v159 frequency_tv_mother 

rename v106 education_level_mother
label var education_level "Level of Education (Mother)"
*recode education_level (0=.)
rename v133 years_education_mother
label var years_education "Year of Education (Mother)" 

rename v463z tobacco_use_mother
label var tobacco_use_mother "Mother Uses Tobacco"

recode tobacco_use_mother (1=2) 
recode tobacco_use_mother (0=1)
recode tobacco_use_mother (2=0)
label define v463z_new 1 "Yes" 0 "No"
label values tobacco_use_mother v463z_new
rename v483a time_health_facility
label var time_health_facility "Time to Nearest Healthcare"


* Create Male Characteristics

rename mv012 current_age_male
label var current_age_male "Father's Age"
rename mv013 husband_age_group
rename mv131 ethnicity_male
rename mv133 educ_years_male
rename mv157 frequency_newspaper_male
rename mv158 frequency_radio_male
rename mv159 frequency_tv_male
rename mv167 home_away_male

rename mv168 away_more_male
rename mv212 age_first_birth_male
label var age_first_birth_male "Age at First Birth (Father)"
*rename mv248 father_antenatal_check
rename mv463z tobacco_use_male
label var tobacco_use_male "Use of Tobacco by Male"
rename mv716 occupation_male
rename mv732 employed_annual_male
rename mv169a own_mobile_male
rename mv171a use_internet_male
rename mv171b frequency_internet_male

rename mv106 education_level_male
label var education_level_male "Father's Education Level"
rename mv107 education_year_male
label var education_year_male "Years of Education (Father)"
*recode education_level_male (0=.)


rename mv503 number_union_male
label var number_union_male "Number of Union (Father)"

rename mv714 working_father
label var working_father "Father Working"

**Creating Household Characteristics

rename v115 time_watersource
rename v120 hh_has_radio
rename v121 hh_has_tv
rename v123 hh_has_bicycle
rename v124 hh_has_motorcycle
rename v125 hh_has_car
rename v153 hh_has_telephone

rename v005 sample_weight



//Infant Death//
gen infant_death=0
replace infant_death=1 if dead_alive==0 & age_at_death<=12
label var infant_death "Infant Death"

order infant_death, after (year_of_death)

gen post_2015=0 if year_birth<2015
replace post_2015=1 if year_birth>=2015 
label var post_2015 "Post Earthquake"
label define earthquake_label 0"Pre-Earthquake" 1"Post-Earthquake"
label values post_2015 earthquake_label

gen treatment_district=0
replace treatment_district=1 if  inlist(district, 36, 30, 29, 28, 23, 22, 21, 31, 20, 12, 24, 25, 26, 27)
label var treatment_district "Earthquake Affected Districts"
label define treat_dist 0 "Control" 1 "Earthquake Affected"
label values treatment_district treat_dist


//Occupation and other Variable//
label define v106 1 "Primary" 2 "Secondary" 3 "Higher", modify

tab occupation_mother
codebook occupation_mother
label define v716 1 "Professional/Technical/Managerial" 2 "Clerical" 3 "Sales & Service" 4 "Skilled Manual" 5 "Unskilled Manual" 6 "Agriculture", modify
recode occupation_mother (0 8 9 96 996=.)




gen female_infant_death=0
replace female_infant_death=1 if infant_death==1 & sex_child==1

order female_infant_death, after(infant_death)

gen male_infant_death=0
replace male_infant_death=1 if infant_death==1 & sex_child==0

order male_infant_death, after(female_infant_death)

label var female_infant_death "Infant Death(Female)"
label var male_infant_death "Infant Death(Male)"
label var sex_child "Sex"
label var age_at_death "Age at Death(in months)"

label var mothers_age_group "Mother's Age Group" 


recode num_union (1=0)(2=1)
label define v503 0"Single" 1"Multiple", modify
label values num_union v503

recode age_first_sex (96=.)


recode earning_type (0=4)
label define v741 4"not paid", modify
label values earning_type v741 

recode ethnicity_mother (2 3 = 1) (7 8 9 = 2) (5 6 = 3) (10 = 4) (996 4 11 = 5) (96=.)
label define v131 1 "Brahmin/Chhetri" 2 "Janajati" 3 "Dalit" 4 "Muslim" 5 "Other", modify
label values ethnicity_mother v131


rename mv130 religion_male









recode number_union_male (1=0)(2=1)
label define mv503 0"Single" 1"Multiple", modify
label values number_union_male mv503

rename mv201 tot_children_male

rename mv155 literacy_male 
recode literacy_male (2=1)

rename v155 mother_literacy
recode mother_literacy (2=1) (3 4 =.)


recode time_watersource (996=0)(997 998=.)
label var time_watersource "Time to water Source(minutes)"


recode tobacco_use_male (1=2)
recode tobacco_use_male (0=1)
recode tobacco_use_male (2=0)

label define male_tobacco 1 "Yes" 0 "No"
label values tobacco_use_male male_tobacco

rename mv531 age_first_sex_male
recode age_first_sex_male (97=.)


recode occupation_male (0 8 9 96 996 99998=.)

recode employed_annual_male (1=0)(2=1)(3=2)
label define mv732 0 "All Year" 1 "Seasonal" 2 "Occassional", modify
label values employed_annual_male mv732

rename mv741 earning_type_male

rename v504 residing_with_partner
recode residing_with_partner (2=0)
label define v504 0 "Living Elsewhere", modify

rename v730 partners_age
gen partners_age_group=.
replace partners_age_group=1 if partners_age<=19
replace partners_age_group =2 if partners_age>=20 & partners_age<=24
replace partners_age_group =3 if partners_age>=25 & partners_age<=29
replace partners_age_group =4 if partners_age>=30 & partners_age<=34
replace partners_age_group =5 if partners_age>=35 & partners_age<=39
replace partners_age_group =6 if partners_age>=40 & partners_age<=44
replace partners_age_group =7 if partners_age>=45 & partners_age<=49
replace partners_age_group =8 if partners_age>=50 & partners_age<=54
replace partners_age_group =9 if partners_age>=55 & partners_age<=59
replace partners_age_group =10 if partners_age>=60 & partners_age<=64
replace partners_age_group =11 if partners_age>=65 & partners_age<=69
replace partners_age_group =12 if partners_age>=70 & partners_age<=.
replace partners_age_group=. if partners_age==.

label define age_group 1 "15-19" 2 "20-24" 3 "25-29" 4 "30-34" 5 "35-39" 6 "40-44" 7 "45-49" 8 "50-54" 9 "55-59" 10 "60-64" 11 "65-69" 12 "70+"
label values partners_age_group age_group


rename v701 partners_edu_level
recode partners_edu_level ( 8=.)
label define v701 0 "No Education" 1 "Primary" 2 "Secondary" 3 "Higher", modify


gen partner_working=.
replace partner_working=0 if v704==0
replace partner_working=1 if v704==1|v704==2|v704==3|v704==4|v704==5|v704==6|v704==8|v704==9|v704==96|v704==996|v704==998|v704==99998
label var partner_working "Husband/Partner is working"
label define partner_work 1 "Yes" 0 "No"

rename v704 partners_occupation
codebook partners_occupation
label define v704 1 "Professional/Technical/Managerial" 2 "Clerical" 3 "Sales & Service" 4 "Skilled Manual" 5 "Unskilled Manual" 6 "Agriculture", modify
recode partners_occupation (0 8 9 96 996 998 99998=.)


gen wt= sample_weight/1000000
*svyset [pw=wt], psu(v021) strata(v023) singleunit(centered)

replace height_age_sd = . if height_age_sd == 9998
replace height_age_sd = . if height_age_sd == .a
replace weight_age_sd = . if weight_age_sd == 9998
replace weight_age_sd = . if weight_age_sd == .a
replace weight_height_sd = . if weight_height_sd == 9998
replace weight_height_sd = . if weight_height_sd == .a
replace bmi_sd = . if bmi_sd == 9998
replace bmi_sd = . if bmi_sd == .a

tab birth_order, gen(birth_order_)

drop birth_order

save "$workdir/kid_level_final_data.dta", replace
