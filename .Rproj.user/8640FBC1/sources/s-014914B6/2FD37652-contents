get_away_team_tbl <- function(webpage, headings){

  webpage <- read_html(webpage)
  table_away <- webpage %>% 
    html_nodes("table") %>% 
    .[6:10] %>% 
    html_table(fill = TRUE)
  
  
  
  table <- table_away[[1]]
  
  away <- colnames(table)
  
  
  
  away_table <- table_away %>% 
    reduce(full_join, by = c(away[1], away[2]))
  
  names(away_table) <- c("position", "player", headings)
  
  away_table<- away_table %>% 
    mutate(country = away[2], .before = player) %>% 
    drop_na(position) %>% 
    mutate(across(headings, as.numeric))
  
  return(away_table)
}