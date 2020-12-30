create_round_data <- function(round, no){
  
  for (webpage in round) {
  
  # Create temp folder for overall stats
  dir.create("temp_player")
  dir.create("temp_team")
  
    # Create round folder for individual matches
  round_dir_path <- paste("2_data/round_", no, sep = "")
  dir.create(round_dir_path)
  
  # Crette round temp folder team and player stat
  round_temp_player_dir_path <- paste("2_data/round_", no,"/temp_player", sep = "")
  dir.create(round_temp_player_dir_path)
  
 
  round_temp_team_dir_path <- paste("2_data/round_", no,"/temp_team", sep = "")
  dir.create(round_temp_team_dir_path)
  
  # get match and date from url 
  match <- str_extract(webpage, "[a-z-]+[0-9]{8}") %>%
    str_replace_all("-", "_") %>%
    str_extract("[a-z_]+(?=_at)")
  
  date <- str_extract(webpage, "[0-9]{8}")
  

  #create match directories
  match_dir_path <- paste("2_data/round_", no, "/", match, sep = "")
  match_player_dir_path <- paste("2_data/round_", no, "/", match, "/player_stats", sep = "")
  match_team_dir_path <- paste("2_data/round_", no, "/", match, "/team_stats", sep = "")
  
  dir.create(match_dir_path)
  dir.create(match_player_dir_path)
  dir.create(match_team_dir_path)
  
  # get home and team 
  headings <- get_tbl_headings(webpage)
  
  home_table <- get_home_team_tbl(webpage, headings) %>% 
    mutate(date = as.numeric(date), .before = position) %>% 
    mutate(date = dmy(date),
           match = match, .after = date)
    
  away_table <- get_away_team_tbl(webpage, headings)%>% 
    mutate(date = as.numeric(date), .before = position) %>% 
    mutate(date = dmy(date),
           match = match, .after = date)
  
  player_csv_path <- paste("2_data/round_", no, "/", match, "/player_stats/", match, "_stats.csv", sep = "")
 team_csv_path <- paste("2_data/round_", no, "/", match, "/team_stats/", match, "_team_stats.csv", sep = "")
  
  full_table <- home_table %>%
    bind_rows(away_table)  
  
  summarised_team_stats <- full_table %>% 
    select(-date:-position, - player) %>% 
    group_by(country) %>% 
    summarise_all(sum)
  
  remaining_team_stats <- get_team_stats(webpage)
  
  full_team_stats <- summarised_team_stats %>% 
    full_join(remaining_team_stats) %>% 
  
    mutate(date = as.numeric(date), .before = country) %>% 
    mutate(date = dmy(date),
           match = match, .after = date) %>% 
    write_csv(team_csv_path)
    
  
  
  full_table %>%
    write_csv(player_csv_path)
  
  
  
  
  home_team <- get_team(home_table)
  home_file_path <- paste("2_data/round_", no,"/temp_player/", home_team, "_", date, ".csv", sep = "")
  temp_home_file_path <- paste("temp_player/", home_team, "_", date, ".csv", sep = "")
  
  home_table %>% 
    write_csv(home_file_path) %>% 
    write_csv(temp_home_file_path)
  
  away_team <- get_team(away_table)
 
  away_file_path <- paste("2_data/round_", no,"/temp_player/", away_team, "_", date, ".csv", sep = "")
  temp_away_file_path <- paste("temp_player/", away_team, "_", date, ".csv", sep = "")
  
  away_table %>% 
    write_csv(away_file_path) %>% 
    write_csv(temp_away_file_path )
  
  team_file_path <- paste("2_data/round_", no,"/temp_team/", match, "_", date, ".csv", sep = "")
  temp_team_file_path <- paste("temp_team/", match, "_", date, ".csv", sep = "")
  
  full_team_stats  %>%
    write_csv(team_file_path ) %>% 
    write_csv(temp_team_file_path)
  }
  
  
  files <- c()
  

  
  for (file in list.files(round_temp_player_dir_path)){
    file_path <- paste(round_temp_player_dir_path, "/", file, sep = "")
    files <- c(files, file_path)
  }
  
  complete_data <- NULL
  
  for (file in files){
    part_data <- read_csv(file)
    complete_data <-bind_rows(complete_data, part_data)
    
  }
  
  complete_data %>% 
    write_csv(paste(round_dir_path, "/round_", no,"_player_stats.csv", sep = ""))
  
  
  files <- c()
  
  
  
  for (file in list.files(round_temp_team_dir_path)){
    file_path <- paste(round_temp_team_dir_path, "/", file, sep = "")
    files <- c(files, file_path)
  }
  
  complete_data <- NULL
  
  for (file in files){
    part_data <- read_csv(file)
    complete_data <-bind_rows(complete_data, part_data)
    
  }
  
  complete_data %>% 
    write_csv(paste(round_dir_path, "/round_", no,"_team_stats.csv", sep = ""))
  
  unlink(round_temp_team_dir_path, recursive = TRUE)
  unlink(round_temp_player_dir_path, recursive = TRUE)
}