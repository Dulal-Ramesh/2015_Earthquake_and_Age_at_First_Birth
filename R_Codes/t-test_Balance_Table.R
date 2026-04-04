# ==============================================================================
# Project Title : 2015 Earthquake and Age at First Birth
# Description   : Balance Table - Pre and Post Earthquake t-tests
# Dataset       : Nepal Demographic Health Survey (NDHS)
# Author        : Ramesh Dulal
# ==============================================================================
# NOTE: All paths (modified_data, tables) are defined in Master.R
#       Run this script via Master.R only, not directly.
# ==============================================================================

library(haven)    # to read .dta files
library(dplyr)    # for data manipulation

# ==============================================================================
# SECTION 1: LOAD DATA
# ==============================================================================

final_data <- read_dta(file.path(modified_data, "final_data.dta"))

# ==============================================================================
# SECTION 2: DEFINE VARIABLES TO TEST
# ==============================================================================

vars <- c(
  "age_first_birth_mother", "mothers_age", 
  "num_union_mother", "mother_working", "tot_children_mother", "avg_birth_gap",
  "mom_employed_1", "mom_employed_2", "mom_employed_3",
  "mom_ethnicity_1", "mom_ethnicity_2", "mom_ethnicity_3", "mom_ethnicity_4", "mom_ethnicity_5",
  "mom_occ_1", "mom_occ_2", "mom_occ_3", "mom_occ_4", "mom_occ_5", "mom_occ_6",
  "mom_educ_1", "mom_educ_2", "mom_educ_3", "mom_educ_4",
  "partners_age",
  "part_educ_1", "part_educ_2", "part_educ_3", "part_educ_4",
  "part_occ_1", "part_occ_2", "part_occ_3", "part_occ_4", "part_occ_5", "part_occ_6"
)

# ==============================================================================
# SECTION 3: FUNCTION TO RUN T-TESTS
# Runs t-test for each variable by treatment_district (0=control, 1=treat)
# Returns a data frame with means, difference, t-statistic, and p-value
# ==============================================================================

run_ttests <- function(data, variables) {
  results <- lapply(variables, function(var) {
    if (!var %in% names(data)) {
      warning(paste("Variable not found:", var))
      return(NULL)
    }
    treat <- data[[var]][data$treatment_district == 1]
    ctrl  <- data[[var]][data$treatment_district == 0]
    tt <- tryCatch(t.test(treat, ctrl), error = function(e) NULL)
    if (is.null(tt)) return(NULL)
    data.frame(
      variable   = var,
      mean_treat = mean(treat, na.rm = TRUE),
      mean_ctrl  = mean(ctrl,  na.rm = TRUE),
      difference = mean(treat, na.rm = TRUE) - mean(ctrl, na.rm = TRUE),
      t_stat     = tt$statistic,
      p_value    = tt$p.value,
      stringsAsFactors = FALSE
    )
  })
  do.call(rbind, results)
}

# ==============================================================================
# SECTION 4: RUN T-TESTS FOR PRE AND POST EARTHQUAKE
# ==============================================================================

pre_data     <- final_data %>% filter(year_birth >= 2010 & year_birth < 2015)
pre_treat_n  <- sum(pre_data$treatment_district == 1, na.rm = TRUE)
pre_ctrl_n   <- sum(pre_data$treatment_district == 0, na.rm = TRUE)
pre_results  <- run_ttests(pre_data, vars)

post_data    <- final_data %>% filter(year_birth >= 2015 & year_birth < 2020)
post_treat_n <- sum(post_data$treatment_district == 1, na.rm = TRUE)
post_ctrl_n  <- sum(post_data$treatment_district == 0, na.rm = TRUE)
post_results <- run_ttests(post_data, vars)

# ==============================================================================
# SECTION 5: MERGE PRE AND POST RESULTS
# ==============================================================================

combined <- merge(pre_results, post_results, by = "variable", suffixes = c("_pre", "_post"))

# ==============================================================================
# SECTION 6: ADD SIGNIFICANCE STARS
# ==============================================================================

add_stars <- function(p) {
  ifelse(p < 0.01, "***", ifelse(p < 0.05, "**", ifelse(p < 0.1, "*", "")))
}

combined$stars_pre  <- add_stars(combined$p_value_pre)
combined$stars_post <- add_stars(combined$p_value_post)

# ==============================================================================
# SECTION 7: VARIABLE LABELS
# ==============================================================================

labels <- c(
  age_first_birth_mother = "Age at First Birth",
  mothers_age            = "Mother's Age",
  num_union_mother       = "Number of Union",
  mother_working         = "Mother is Working",
  tot_children_mother    = "Number of Kids",
  avg_birth_gap          = "Average Birth Gap",
  partners_age           = "Partner's Age",
  mom_educ_1             = "\\hspace{0.2in}No Education",
  mom_educ_2             = "\\hspace{0.2in}Primary Education",
  mom_educ_3             = "\\hspace{0.2in}Secondary Education",
  mom_educ_4             = "\\hspace{0.2in}Higher Education",
  mom_employed_1         = "\\hspace{0.2in}All Year Employed",
  mom_employed_2         = "\\hspace{0.2in}Seasonal Employed",
  mom_employed_3         = "\\hspace{0.2in}Occasional Employed",
  mom_ethnicity_1        = "\\hspace{0.2in}Brahmin/Chhetri",
  mom_ethnicity_2        = "\\hspace{0.2in}Janajati",
  mom_ethnicity_3        = "\\hspace{0.2in}Dalit",
  mom_ethnicity_4        = "\\hspace{0.2in}Muslim",
  mom_ethnicity_5        = "\\hspace{0.2in}Other",
  mom_occ_1              = "\\hspace{0.2in}Prof/Tech/Managerial",
  mom_occ_2              = "\\hspace{0.2in}Clerical",
  mom_occ_3              = "\\hspace{0.2in}Sales and Services",
  mom_occ_4              = "\\hspace{0.2in}Skilled Manual",
  mom_occ_5              = "\\hspace{0.2in}Unskilled Manual",
  mom_occ_6              = "\\hspace{0.2in}Agriculture",
  part_educ_1            = "\\hspace{0.2in}No Education",
  part_educ_2            = "\\hspace{0.2in}Primary Education",
  part_educ_3            = "\\hspace{0.2in}Secondary Education",
  part_educ_4            = "\\hspace{0.2in}Higher Education",
  part_occ_1             = "\\hspace{0.2in}Prof/Tech/Managerial",
  part_occ_2             = "\\hspace{0.2in}Clerical",
  part_occ_3             = "\\hspace{0.2in}Sales and Services",
  part_occ_4             = "\\hspace{0.2in}Skilled Manual",
  part_occ_5             = "\\hspace{0.2in}Unskilled Manual",
  part_occ_6             = "\\hspace{0.2in}Agriculture"
)

combined$varname <- ifelse(
  combined$variable %in% names(labels),
  labels[combined$variable],
  combined$variable
)

# ==============================================================================
# SECTION 8: CATEGORY HEADERS
# ==============================================================================

combined$category <- ""
combined$category[grepl("^mom_educ_",      combined$variable)] <- "Mother's Education"
combined$category[grepl("^mom_employed_",  combined$variable)] <- "Mother's Employment"
combined$category[grepl("^mom_ethnicity_", combined$variable)] <- "Mother's Ethnicity"
combined$category[grepl("^mom_occ_",       combined$variable)] <- "Mother's Occupation"
combined$category[grepl("^part_educ_",     combined$variable)] <- "Partner's Education"
combined$category[grepl("^part_occ_",      combined$variable)] <- "Partner's Occupation"

# ==============================================================================
# SECTION 9: WRITE LATEX TABLE
# ==============================================================================

out_file <- file.path(tables, "balance_table_combined.tex")
con <- file(out_file, open = "w")

writeLines("\\documentclass{article}",  con)
writeLines("\\usepackage{booktabs}",    con)
writeLines("\\begin{document}",         con)
writeLines("\\begin{table}[htbp]",      con)
writeLines("\\centering",               con)
writeLines("\\scriptsize",              con)
writeLines("\\caption{Balance Table: Pre- and Post-Earthquake}", con)
writeLines("\\begin{tabular}{lcccccc}", con)
writeLines("\\toprule",                 con)
writeLines("Variable & Pre-Treat & Pre-Control & Pre-Diff & Post-Treat & Post-Control & Post-Diff \\\\", con)
writeLines("\\midrule",                 con)

printed_categories <- c()

for (i in seq_len(nrow(combined))) {
  cat_i <- combined$category[i]
  if (cat_i != "" && !cat_i %in% printed_categories) {
    writeLines(paste0("\\multicolumn{7}{l}{\\textbf{", cat_i, "}} \\\\"), con)
    printed_categories <- c(printed_categories, cat_i)
  }
  writeLines(paste0(
    combined$varname[i], " & ",
    sprintf("%.3f", combined$mean_treat_pre[i]),  " & ",
    sprintf("%.3f", combined$mean_ctrl_pre[i]),   " & ",
    sprintf("%.3f", combined$difference_pre[i]),  combined$stars_pre[i],  " & ",
    sprintf("%.3f", combined$mean_treat_post[i]), " & ",
    sprintf("%.3f", combined$mean_ctrl_post[i]),  " & ",
    sprintf("%.3f", combined$difference_post[i]), combined$stars_post[i], " \\\\"
  ), con)
  writeLines(paste0(
    " & & & (", sprintf("%.2f", combined$t_stat_pre[i]),  ") & ",
    "& & (", sprintf("%.2f", combined$t_stat_post[i]), ") \\\\"
  ), con)
}

writeLines("\\midrule", con)
writeLines(paste0(
  "Total Observations & ", pre_treat_n, " & ", pre_ctrl_n,
  " & & ", post_treat_n, " & ", post_ctrl_n, " & \\\\"
), con)
writeLines("\\bottomrule", con)
writeLines("\\multicolumn{7}{l}{\\footnotesize Notes: * p<0.10, ** p<0.05, *** p<0.01} \\\\", con)
writeLines("\\end{tabular}", con)
writeLines("\\end{table}",   con)
writeLines("\\end{document}", con)

close(con)
cat("✓ Balance table saved to:", out_file, "\n")