consolidate_tournament_data <- function(file_path){

files <- c()

for (file in list.files(file_path)) {
  file_path <- paste(file_path, "/", file, sep = "")
  files <- c(files, file_path)
}

complete_data <- NULL

for (file in files) {
  part_data <- read_csv(file)
  complete_data <- bind_rows(complete_data, part_data)
}

save_player <- paste(file_path, "/full_table_player.csv")
complete_data %>%
  write_csv(save_player)






# Team data

files <- c()

for (file in list.files(file_path)) {
  file_path <- paste(file_path, "/", file, sep = "")
  files <- c(files, file_path)
}

complete_data <- NULL

for (file in files) {
  part_data <- read_csv(file)
  complete_data <- bind_rows(complete_data, part_data)
}

complete_data %>%
  write_csv("2_data/full_table_team.csv")



unlink(file_path, recursive = TRUE)
unlink(file_path, recursive = TRUE)
}
