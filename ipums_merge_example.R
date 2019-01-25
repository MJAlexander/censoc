## Example file to merge censoc dataset with publicly available IPUMS full count 1940 census data
## Note: to obtain IPUMS file see documentation

library(data.table)
library(tidyverse)

# file paths for censoc and IPUMS census data
censoc_path <- "path/to/your/censoc"
census_path <- "path/to/your/census"

# read in censoc data
censoc <- fread(censoc_path)

# read in ipums data
census <- fread(census_path)

setkey(censoc, HISTID)
setkey(census, HISTID)

merged_df <- censoc[census, nomatch=0]

rm(censoc)
rm(census)

# Example: calculate average age of death by race -------------------------

# only keep neccesary columns
merged_df <- merged_df[,c("unique_id", "STATEFIP",
                          "AGE", "byear", "dyear", "bmonth", "dmonth",
                          "RACE")]

# code the race variable to have meaningful names, see: https://usa.ipums.org/usa-action/variables/RACE#codes_section
merged_df <- merged_df %>% mutate(race_name = case_when(
  RACE == 1 ~ "White",
  RACE == 2 ~ "Black",
  RACE == 3 ~ "American Indian/Alaskan native",
  RACE == 4 ~ "Chinese",
  RACE == 5 ~ "Japanese",
  RACE == 6 ~ "Other Asian or Pacific Islander",
  TRUE ~ "NA"
))

# calculate age at death
merged_df[, age_at_death := dyear - byear]

# calculate average age at death by race
merged_df %>% group_by(race_name) %>%
  summarise(mean_age_at_death = mean(age_at_death))


