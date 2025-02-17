# proc qualtrics

library(tidyverse)
hds <- read_csv("data/hds.csv") # create appropriate HDS data first

hds <- hds %>% 
  distinct(item_num, item, ans_ind, ans_text) %>% 
  cross_join(hds %>% distinct(state)) %>% 
  left_join(hds) %>% 
  replace_na(list(ans_prop = 0))

out <- hds %>% 
  distinct(item, ans_ind, ans_text) %>% 
  mutate(ans_text = paste0(ans_ind,". ", ans_text)) %>% 
  pivot_wider(id_cols = item, names_from = ans_ind, values_from=ans_text) %>% 
  relocate(item, a, b, c, d, e, f, g, h, i, j, k, l, m) %>% 
  mutate_at(vars(-item), ~ifelse(is.na(.x), "", .x))


survey_fake <- read_csv("data/dialect-survey.csv")


read_qualtrics <- function(fname){
  colnames <- colnames(read_csv(fname))
  survey_q <- read_csv(fname, skip = 3, col_names = colnames)
  
  return(survey_q)
}

survey_q <- read_qualtrics("proc/hds/ASU+dialect+survey+-+BDSR2_January+21,+2025_10.42.csv")

s <- survey_q %>% 
  select(name, state_of_birth, states_lived, contains("_dialect")) %>% 
  pivot_longer(
    cols = contains("_dialect"),
    names_to = "item_num",
    values_to = "ans_ind"
  ) %>% 
  rename(state = state_of_birth) %>% 
  mutate(state = str_to_lower(state), states_lived = str_to_lower(states_lived)) %>% 
  mutate(item_num = as.numeric(gsub("_dialect", "", item_num))) %>%
  left_join(out %>% select(item) %>% mutate(item_num = 1:n()), by = c("item_num")) %>% 
  select(-item_num) %>% 
  left_join(hds %>% distinct( ans_ind, item_num, item,ans_text), by = c("item", "ans_ind") )
  
x <- survey_fake %>% 
  mutate(states_lived = state) %>% 
  bind_rows(s)

x <- x %>% 
  mutate(name = case_when(
    name == "Matt" ~ "mb",
    name == "Ayah Abu Zour" ~ "Ayz",
    name == "Rose Eerdmans" ~ "RE",
    name == "Alex Pedraza" ~ "Apx",
    name == "Gabriell Young" ~ "gg",
    name == "Emma Saiter" ~ "Se",
    name == "Allie Cross" ~ "AC",
    name == "Natalie Rossman" ~ "NRo",
    name == "Taylor Lebensfeld" ~ "TTL",
    name == "Kristen" ~ "gj",
    name == "Yasaman" ~ "yy",
    TRUE ~ name
  ))

# items <- x %>% 
#   distinct(item, item_num)
# 
# z <- x %>% left_join(items, by = "item")
z <- x %>% 
  mutate(
    item_num = if_else(is.na(item_num), 50, item_num)
    )

write_csv(z, "data/dialect-survey-full-s25.csv")
