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
*	Merging Birth Gap, Breastfeeding, and Migration Datasets                   *
* NOTE: All path globals ($modified_data) are defined in Master.do.           *
*       Run via Master.do only.                                                *
*------------------------------------------------------------------------------*


global workdir "$modified_data"


use "$workdir/kid_level_final_data.dta", clear

label var year "Survey Year"
gen unique_id = _n
gen long kid_id = year * 100000 + unique_id

drop unique_id mothers_id caseid 
order kid_id year_birth, before(year)
order wt, before (sample_weight)

drop d127a d127b d127c d127d d127e d127f d127g d127h bidx_  birth_month year_of_death d102 d104 d108 d115b d115c d115d d115f d115g d115j d115k d115l d115o d115p d115q d118a d118b d118c d118d d118f d118g d118j d118k d118l d118o d118p d118q

gen post_treatment = post_2015 * treatment_district
//Upto this point we have kid's level dataset//

// For collapsing the Dataset //

keep year_birth district wt sex_child birth_order_* treatment_district post_2015 post_treatment mothers_age ///
    employed_annual_mother marriage_age mothers_age_group ethnicity_mother age_first_birth_mother ///
    num_union_mother mother_working occupation_mother education_level_mother ///
    tot_children_mother partners_age_group partners_edu_level partners_occupation ///
    partners_age
	

gen male = sex_child == 0
gen female = sex_child == 1

tab employed_annual_mother, gen(mom_employed_)
tab mothers_age_group, gen(mom_agegrp_)
tab ethnicity_mother, gen(mom_ethnicity_)
tab occupation_mother, gen(mom_occ_)
tab education_level_mother, gen(mom_educ_)
tab partners_age_group, gen(part_agegrp_)
tab partners_edu_level, gen(part_educ_)
tab partners_occupation, gen(part_occ_)

collapse (sum) male female birth_order_* mom_employed_*  mom_agegrp_* mom_ethnicity_* mom_occ_* mom_educ_* part_agegrp_* part_educ_* part_occ_* (mean) mothers_age marriage_age age_first_birth_mother num_union_mother mother_working tot_children_mother partners_age [pw = wt], by(district year_birth)

keep if year_birth >= 2010 
drop if year_birth >= 2020

merge 1:1 district year_birth using "$workdir/collapsed_birth_gap.dta" 
drop _merge

//Merging the dataset with breastfeeding dataset//

merge 1:1 district year_birth using "$workdir/women_breastfeed_2011_16_22.dta"
drop _merge

//Merging the dataset with Male Migration Data//

*merge 1:1 district year_birth using "$workdir/migration_population.dta"
*drop if _merge == 2
*drop if _merge == 1
*drop _merge


gen post_2015 = year_birth >= 2015

gen treatment_district = inlist(district, 36, 30, 29, 28, 23, 22, 21, 31, 20, 12, 24, 25, 26, 27)

gen did = post_2015 * treatment_district

save "$workdir/final_data.dta", replace
