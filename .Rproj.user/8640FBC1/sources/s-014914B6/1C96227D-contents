get_home_team_tbl <- function(webpage, headings){


  table_home <- webpage %>% 
    html_nodes("table") %>% 
    .[1:5] %>% 
    html_table(fill = TRUE)
  
  
  
  table <- table_home[[1]]
  
  home <- colnames(table)
  
  
  
  home_table <- table_home %>% 
    reduce(full_join, by = c(home[1], home[2]))
  
  names(home_table) <- c("position", "player", headings)
  
  home_table<- home_table %>% 
    mutate(country = home[2], .before = player) %>% 
    drop_na(position) %>% 
    mutate(across(try_scored:yellow_card, as.numeric))
  
  return(home_table)
}