# ==============================================================================
# Project Title : 2015 Earthquake and Age at First Birth
# Author        : Ramesh Dulal
# Description   : Master R script. Runs all R scripts in sequence.
# Last Updated  : April 2026
# ==============================================================================


# ==============================================================================
# SECTION 1: PATH DEFINITIONS
# ==============================================================================

user <- Sys.getenv("USER")    # detects your Mac/Linux username automatically
# (equivalent to c(username) in Stata)

if (user == "rameshdulal") {
  dropbox <- "/Users/rameshdulal/Library/CloudStorage/Dropbox"
  github  <- "/Users/rameshdulal/Documents/Web Portfolio/Dissertation/2015_Earthquake_and_Age_at_First_Birth"
  
} else if (user == "drghosh") {              # ← replace with your username. In your R Console type Sys.getenv("USER") 
  dropbox <- "/Users/drghosh/Dropbox"        # ← replace with your actual Dropbox path
  github  <- "/Users/drghosh/..."            # ← replace with your actual GitHub repo path
  
} else {
  stop(paste(
    "ERROR: Unrecognized user '", user, "'.",
    "Please add your paths to Master.R"
  ))
}

# ── All other paths built from roots (same for everyone) ─────────────────── #
modified_data <- file.path(dropbox, "2015 Earthquake and A1B/Data/Modified_Data")
r_scripts     <- file.path(github,  "R_Codes")
figures       <- file.path(github,  "Paper/Figures")
tables        <- file.path(github,  "Paper/Tables New")


# ==============================================================================
# SECTION 2: LOG FILE
# ==============================================================================

today   <- format(Sys.Date(), "%m-%d-%Y")
log_file <- file.path(modified_data, paste0("log_master_R_", today, ".txt"))
con      <- file(log_file, open = "wt")
sink(con, append = FALSE, split = TRUE)   # prints to both console and log
cat("Master.R started:", format(Sys.time()), "\n\n")


# ==============================================================================
# SECTION 3: RUN EACH R SCRIPT IN SEQUENCE

# ==============================================================================

cat("========================================================\n")
cat(" STEP 4: Balance Table (Pre vs Post Earthquake t-tests)\n")
cat("========================================================\n")
#source(file.path(r_scripts, "ttest_balance_table.R"))


# ==============================================================================
# END OF MASTER R FILE
# ==============================================================================

cat("\n✓ All R steps completed successfully.\n")
cat("Session ended:", format(Sys.time()), "\n")
sink()
close(con)