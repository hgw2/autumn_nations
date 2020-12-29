get_tbl_headings <- function(webpage){
  
  headings <- webpage %>% 
    html_nodes("table") %>% 
    .[11:15] %>% 
    html_table(fill = TRUE)
  
  headings <- headings%>% 
    reduce(bind_rows)
  
  
  headings <- pull(headings[2])
  
  headings <- str_to_lower(headings) %>% 
    str_replace_all(" ", "_")
  
  return(headings)
}

headings <- get_tbl_headings(read_html("https://www.rugbypass.com/live/autumn-nations-cup/ireland-vs-wales-at-aviva-stadium-on-13112020/2020/stats/"))