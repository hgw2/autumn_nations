library(miceadds)
library(rvest)
library(lubridate)
library(tidyverse)

source.all("functions")

webpage <- "https://www.rugbypass.com/internationals/matches"

links <- get_match_links(webpage)

scrape_rugby_pass_data(links)


