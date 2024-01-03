library(tidyverse)
hds <- read_csv("data/hds.csv") # create appropriate HDS data first

set.seed(123)

hds <- hds %>% 
  distinct(item, ans_ind, ans_text) %>% 
  cross_join(hds %>% distinct(state)) %>% 
  left_join(hds) %>% 
  replace_na(list(ans_prop = 0))


hds <- hds %>%
  group_by(state, item) %>%
  mutate(ans_prop = if_else(ans_prop==0, min(ans_prop/100., na.rm=T)/10, ans_prop/100.)) %>%
  mutate(ans_prop = ans_prop/sum(ans_prop))


state_pops <- read_csv("https://gist.githubusercontent.com/bradoyler/0fd473541083cfa9ea6b5da57b08461c/raw/fa5f59ff1ce7ad9ff792e223b9ac05c564b7c0fe/us-state-populations.csv")


survey <- state_pops %>% 
  mutate(prob = pop_2014/sum(pop_2014)) %>% 
  sample_n(500, replace = TRUE, weight = prob) %>% 
  select(state) %>% 
  filter(state != "Alaska", state != "Hawaii", state != "District of Columbia") %>% 
  mutate(state = str_to_lower(state)) %>% 
  # rename(state = code) %>% 
  mutate(name = paste0("anon", 1:n())) 

all <- left_join(survey, hds, by = "state", relationship = "many-to-many")
 
res <- all %>%
  group_by(name, item) %>%
  sample_n(1, weight = ans_prop) %>% 
  select(name, state, item,  item_num, ans_ind, ans_text)


write_csv(res, "data/dialect-survey.csv")
