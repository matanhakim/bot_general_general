# Load libraries
library(tidyverse)

# Define column names
col_names <- paste0("X", str_pad(as.character(1:50), width = 2, side = "left", pad = "0"))

# Read input data frame
df <- read_csv("general_general.csv", col_names = col_names, col_types = "c", trim_ws = FALSE)

# Transform the data frame to a long format
df <- df %>% 
  pivot_longer(everything()) %>% 
  drop_na(value)

tweet <- df %>% 
  group_by(name) %>% 
  slice_sample(n = 1) %>% 
  arrange(name) %>% 
  pull(value) %>% 
  str_c(collapse = "")

tweet
