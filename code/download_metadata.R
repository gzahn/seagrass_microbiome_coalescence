# downloads current metadata sheets from Google Drive
# Need to rerun after any metadata updates

library(googlesheets4)
library(dplyr)
library(tidyr)

# No authentication needed for public sheets
gs4_deauth()

# add links

## phase 1 metadata
urls <- c(
  sites = "https://docs.google.com/spreadsheets/d/1SU2VYWOQ-Ob2JnhVqs7GiR-KVRb4xs5JJd_yMFyj7eo/edit?usp=sharing",
  seqs = "https://docs.google.com/spreadsheets/d/1H90WX5jfnVeueVUSXBB9HPUYTIEFCUKzIyGH2Maqk4s/edit?usp=sharing",
  samps = "https://docs.google.com/spreadsheets/d/1q5PAT23KhXMSpy2DKXyaphIih_a565WYoQa4LuY8deo/edit?usp=sharing",
  greenhouse = "https://docs.google.com/spreadsheets/d/1kTVpIZFeIH0gN4Ma4cyJSEZawCaM4ikM22relD0V9DY/edit?usp=sharing",
  expunits = "https://docs.google.com/spreadsheets/d/1tYB1SBKKvQOqlxcwDsKKiXmRcYoVFKzEokfi_BamcNQ/edit?usp=sharing",
  pheno = "https://docs.google.com/spreadsheets/d/1uq6Q6mqIEbtFra6W31nDPghnhl3VwjWS5DhAaWdYI14/edit?usp=sharing"
)

# Import all sheets into a named list of data frames
dat <- lapply(urls, read_sheet)

# Create individual data frames
list2env(dat, envir = .GlobalEnv)

# write out to files in ./data/phase1/
filenames <- c(
  sites = "metadata_phase-1_sites.csv",
  seqs = "metadata_phase-1_sequencing.csv",
  samps = "metadata_phase-1_samples.csv",
  greenhouse = "metadata_phase-1_greenhouse.csv",
  expunits = "metadata_phase-1_experimental_units.csv",
  pheno = "metadata_phase-1_phenotype_observations.csv"
)

mapply(
  function(df, file) {
    write.csv(df, file.path("./data/phase1", file), row.names = FALSE)
  },
  dat[names(filenames)],
  filenames,
  SIMPLIFY = FALSE
)

# merge all data frames
left_join()
