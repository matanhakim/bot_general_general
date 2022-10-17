# Load libraries
library(tidyverse)
library(rtweet)

# Create Twitter token
general_general_bot_token <- rtweet_bot(
  api_key       = Sys.getenv("TWITTER_CONSUMER_API_KEY"),
  api_secret    = Sys.getenv("TWITTER_CONSUMER_API_SECRET"),
  access_token  = Sys.getenv("TWITTER_ACCESS_TOKEN"),
  access_secret = Sys.getenv("TWITTER_ACCESS_TOKEN_SECRET")
)

# Define column names
col_names <- paste0("X", str_pad(as.character(1:50), width = 2, side = "left", pad = "0"))

# Read input data frame
df <- read_csv("general_general.csv", col_names = col_names, col_types = "c", trim_ws = FALSE)

# Transform the data frame to a long format
df <- df %>% 
  pivot_longer(everything()) %>% 
  drop_na(value)

# Create random Tweet
tweet <- df %>% 
  group_by(name) %>% 
  slice_sample(n = 1) %>% 
  arrange(name) %>% 
  pull(value) %>% 
  str_c(collapse = "")


# Post the tweet to Twitter
post_tweet(
  status = tweet,
  token = londonmapbot_token
)