urls <- c("https://www.rugbypass.com/live/autumn-nations-cup/ireland-vs-wales-at-aviva-stadium-on-13112020/2020/stats/",
          "https://www.rugbypass.com/live/autumn-nations-cup/italy-vs-scotland-at-tbc-on-14112020/2020/stats/",
          "https://www.rugbypass.com/live/autumn-nations-cup/england-vs-georgia-at-twickenham-on-14112020/2020/stats/")

for(webpage in urls){
  
  webpage <- read_html(webpage)
 
   headings <- webpage %>% 
    html_nodes("table") %>% 
    .[11:15] %>% 
    html_table(fill = TRUE)
  
  headings <- headings%>% 
    reduce(bind_rows)
  
  
  headings <- pull(headings[2])
  
  headings <- str_to_lower(headings) %>% 
    str_replace_all(" ", "_")
  
  
  #get home team data
  table_home <- webpage %>% 
    html_nodes("table") %>% 
    .[1:5] %>% 
    html_table(fill = TRUE)
  
  
  
  table <- table_home[[1]]
  
  home <- colnames(table)
  
  
  
  home_table <- table_home %>% 
    reduce(full_join, by = c(home[1], home[2]))
  
  names(home_table) <- c("position", "player", headings)
  
  home_table<- home_table %>% mutate(country = home[2], .before = player) %>% 
    drop_na(position)
  
  
  
  
  #get away team data
  table_away <- webpage %>% 
    html_nodes("table") %>% 
    .[6:10] %>% 
    html_table(fill = TRUE)
  
  
  
  table <- table_away[[1]]
  
  away <- colnames(table)
  
  
  
  away_table <- table_away %>% 
    reduce(full_join, by = c(away[1], away[2]))
  
  names(away_table) <- c("position", "player", headings)
  
  away_table <- away_table %>% mutate(country = away[2], .before = player) %>% 
    drop_na(position)
  
  full_table <- home_table %>% 
    bind_rows(away_table)
  
}