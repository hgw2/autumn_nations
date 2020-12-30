library(miceadds)
library(rvest)
library(lubridate)
library(tidyverse)

source.all("functions/")

round_1 <- c(
  "https://www.rugbypass.com/live/autumn-nations-cup/ireland-vs-wales-at-aviva-stadium-on-13112020/2020/stats/",
  "https://www.rugbypass.com/live/autumn-nations-cup/italy-vs-scotland-at-tbc-on-14112020/2020/stats/",
  "https://www.rugbypass.com/live/autumn-nations-cup/england-vs-georgia-at-twickenham-on-14112020/2020/stats/"
)

round_2 <- c(
  "https://www.rugbypass.com/live/autumn-nations-cup/england-vs-ireland-at-twickenham-on-21112020/2020/stats/",
  "https://www.rugbypass.com/live/autumn-nations-cup/wales-vs-georgia-at-tbc-on-21112020/2020/stats/",
  "https://www.rugbypass.com/live/autumn-nations-cup/scotland-vs-france-at-bt-murrayfield-stadium-on-22112020/2020/stats/"
)

round_3 <- c(
  "https://www.rugbypass.com/live/autumn-nations-cup/wales-vs-england-at-tbc-on-28112020/2020/stats/",
  "https://www.rugbypass.com/live/autumn-nations-cup/france-vs-italy-at-tbc-on-28112020/2020/stats/",
  "https://www.rugbypass.com/live/autumn-nations-cup/ireland-vs-georgia-at-aviva-stadium-on-29112020/2020/stats/"
)

round_4 <- c(
  "https://www.rugbypass.com/live/autumn-nations-cup/georgia-vs-fiji-at-bt-murrayfield-stadium-on-05122020/2020/stats/",
  "https://www.rugbypass.com/live/autumn-nations-cup/ireland-vs-scotland-at-aviva-stadium-on-05122020/2020/stats/",
  "https://www.rugbypass.com/live/autumn-nations-cup/wales-vs-italy-at-parc-y-scarlets-on-05122020/2020/stats/",
  "https://www.rugbypass.com/live/autumn-nations-cup/england-vs-france-at-twickenham-on-06122020/2020/stats/"
)

create_round_data(round_1, 1)
create_round_data(round_2, 2)
create_round_data(round_3, 3)
create_round_data(round_4, 4)

files <- c()

for (file in list.files("temp_player")) {
  file_path <- paste("temp_player/", file, sep = "")
  files <- c(files, file_path)
}

complete_data <- NULL

for (file in files) {
  part_data <- read_csv(file)
  complete_data <- bind_rows(complete_data, part_data)
}

complete_data %>%
  write_csv("2_data/full_tournament_table_player.csv")



unlink("temp_player/", recursive = TRUE)


# Team data

files <- c()

for (file in list.files("temp_team")) {
  file_path <- paste("temp_team/", file, sep = "")
  files <- c(files, file_path)
}

complete_data <- NULL

for (file in files) {
  part_data <- read_csv(file)
  complete_data <- bind_rows(complete_data, part_data)
}

complete_data %>%
  write_csv("2_data/full_tournament_table_team.csv")



unlink("temp_player/", recursive = TRUE)
unlink("temp_team/", recursive = TRUE)
