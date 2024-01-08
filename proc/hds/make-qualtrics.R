# make survey output for qualtrics

library(tidyverse)
hds <- read_csv("data/hds.csv") # create appropriate HDS data first

hds <- hds %>% 
  distinct(item, ans_ind, ans_text) %>% 
  cross_join(hds %>% distinct(state)) %>% 
  left_join(hds) %>% 
  replace_na(list(ans_prop = 0))

out <- hds %>% 
  distinct(item, ans_ind, ans_text) %>% 
  mutate(ans_text = paste0(ans_ind,". ", ans_text)) %>% 
  pivot_wider(id_cols = item, names_from = ans_ind, values_from=ans_text) %>% 
  relocate(item, a, b, c, d, e, f, g, h, i, j, k, l, m) %>% 
  mutate_at(vars(-item), ~ifelse(is.na(.x), "", .x))


write_csv(out, "proc/hds/qualtrics-dm.csv")
