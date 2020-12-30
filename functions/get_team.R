get_team <- function(team){
  
 team <- team %>% 
    distinct(country) %>% 
    pull() %>% 
    str_to_lower()
 
 return(team)
}