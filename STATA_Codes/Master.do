clear all
version 18
capture log close

********************************************************************************
* Project Title : 2015 Earthquake and Age at First Birth                       *
* Author        : Ramesh Dulal                                                  *
* Description   : Master do-file. Defines all global paths and runs each       *
*                 data-cleaning file in sequence.     ```'''                   *
* Last Updated  : March 2026                                                    *
********************************************************************************

*==============================================================================*
*   SECTION 1: GLOBAL PATH DEFINITIONS                                         *
*                        *
*==============================================================================*

* ── Detect user and set root paths only ─────────────────────────────────── *
if "`c(username)'" == "rameshdulal" {
    global dropbox  "/Users/rameshdulal/Library/CloudStorage/Dropbox"
    global github   "/Users/rameshdulal/Documents/Web Portfolio/Dissertation/2015_Earthquake_and_Age_at_First_Birth"
}
else if "`c(username)'" == "drghosh" {        // ← replace with your actual username and you can find your username by running the command  "display c(username)" in STATA
    global dropbox  "/Users/drghosh/Dropbox"  // ← replace with your actual Dropbox path
    global github   "/Users/drghosh/..."      // ← replace with your actual GitHub repo path
}
else {
    display as error "ERROR: Unrecognized user `c(username)'. Add your paths to Master.do."
    exit
}

* ── All other paths built from roots (same for everyone) ────────────────── *
global raw_data      "$dropbox/2015 Earthquake and A1B/Data/Raw_Data"
global modified_data "$dropbox/2015 Earthquake and A1B/Data/Modified_Data"
global dofiles       "$github/Code"
global figures       "$github/Paper/Figures"
global tables        "$github/Paper/Tables New"

*------------------------------------------------------------------------------*
* Individual Raw Data Files (DHS surveys)                                      *
*------------------------------------------------------------------------------*

* Birth records (Individual Recode)
global data_2011_birth "$raw_data/2011/NPIR61DT/NPIR61FL.DTA"
global data_2016_birth "$raw_data/2016/NPIR7HDT/NPIR7HFL.DTA"
global data_2022_birth "$raw_data/2022/NPIR82DT/NPIR82FL.DTA"

* Women's data (same files as birth records — Individual Recode)
global data_2011_women "$raw_data/2011/NPIR61DT/NPIR61FL.DTA"
global data_2016_women "$raw_data/2016/NPIR7HDT/NPIR7HFL.DTA"
global data_2022_women "$raw_data/2022/NPIR82DT/NPIR82FL.DTA"

* Couple Recode
global data_2011_couple "$raw_data/2011/NPCR61DT/NPCR61FL.DTA"
global data_2016_couple "$raw_data/2016/NPCR7HDT/NPCR7HFL.DTA"
global data_2022_couple "$raw_data/2022/NPCR82DT/NPCR82FL.DTA"

* Migration Excel file
global migrant_excel "$raw_data/Migrants-2008-2018-1.xlsx"


*==============================================================================*
*   SECTION 2: LOG FILE                                                         *
*   → Records everything that happens when you run this master file             *
*==============================================================================*

local today = string(date(c(current_date), "DMY"), "%tdNN-DD-CCYY")
log using "$modified_data/log_master_`today'.log", replace text


*==============================================================================*
*   SECTION 3: RUN EACH STEP IN SEQUENCE                                       *
*   → Comment out any step you do NOT want to re-run                           *
*==============================================================================*

display as text "========================================================"
display as text " STEP 1a: Birth Gap Data Cleaning"
display as text "========================================================"
do "$dofiles/Step1_birth_gap.do"

display as text "========================================================"
display as text " STEP 1b: Breastfeeding Data Cleaning"
display as text "========================================================"
do "$dofiles/Step1_breastfeed.do"

display as text "========================================================"
display as text " STEP 1c: Couple + Women Data Cleaning"
display as text "========================================================"
do "$dofiles/Step1_couple_women_combine.do"

display as text "========================================================"
display as text " STEP 1d: Migrant Data Cleaning"
display as text "========================================================"
do "$dofiles/Step1_migrant_data.do"


*==============================================================================*
*   END OF MASTER FILE                                                          *
*==============================================================================*/

log close
