library(miceadds)
library(rvest)
library(lubridate)
library(tidyverse)

source.all("functions")

autumn_nations <- c(
 
  "https://www.rugbypass.com/live/autumn-nations-cup/ireland-vs-wales-at-aviva-stadium-on-13112020/2020/stats/",
  "https://www.rugbypass.com/live/internationals/england-vs-south-africa-at-twickenham-on-03112018/2019/stats/",
  "https://www.rugbypass.com/live/autumn-nations-cup/england-vs-ireland-at-twickenham-on-21112020/2020/stats/",
  
  "https://www.rugbypass.com/live/premiership/sale-sharks-vs-wasps-at-aj-bell-stadium-on-27122020/2020-2021/stats/",
  "https://www.rugbypass.com/live/autumn-nations-cup/england-vs-france-at-twickenham-on-06122020/2020/stats/")


create_tournament_data(autumn_nations)


