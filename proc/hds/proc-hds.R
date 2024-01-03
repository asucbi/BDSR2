library(tidyverse)


make_state_df <- function(fname){
  x <- scan(paste0("proc/hds/harvard dialect survey/", fname), what = "", sep = "\n")
  items <- c()
  opts <- c()
  
  
  for (line in x){
    if (str_starts(line, "^[0-9]")){
      curr_item <- line
    }
    if (str_starts(line, "^[a-z]\\.")){
      items <- c(items, curr_item)
      opts <- c(opts, line)
    }
  }
  
  df <- tibble(
    item = items,
    dat = opts
  )
  
  df %>% 
    mutate(
      ans_ind = str_match(dat, "[a-z]\\. "),
      ans_ind = str_sub(ans_ind, 1, 1),
      ans_text = str_replace(dat, "^[a-z]\\. ", ""),
      ans_prop = str_extract(dat, "\\((\\d+(\\.\\d+)?)%\\)"), #  \\((\\d+(\\.\\d+)?)%\\)
      ans_text = str_sub(str_replace(ans_text, ans_prop, ""), 1, -3),
      ans_text = str_replace_all(ans_text, "\t", ""),
      ans_prop = as.numeric(str_sub(ans_prop, 2, -3))
    ) %>% 
    select(-dat) %>% 
    mutate(state = str_sub(fname, 1, -5))
}

fnames <- list.files("proc/hds/harvard dialect survey/")

full_data <- bind_rows(map(fnames, make_state_df))

states <- state.name
names(states) <- state.abb

full_data <- full_data %>% 
  mutate(
    item_num = str_match(item, "[0-9]+\\. "),
    item = str_replace(item, item_num, ""),
    item_num = str_sub(item_num, 1, -3)
  ) %>% 
  mutate(ans_prop = ans_prop/100) %>% 
  select(state, item_num, item, ans_ind, ans_text, ans_prop) %>% 
  mutate(state = str_to_lower(states[state]))

# question_nums <- c(1, 2, 4, 7, 9, 10, 15, 28, 27, 47, 65, 36, 14, 58, 75, 73, 52, 76, 26, 45)


question_nums <- full_data %>% 
  group_by(item_num, ans_ind) %>% 
  mutate(
    avg_prop = mean(ans_prop, na.rm=T),
    prop_diff = ans_prop - avg_prop
    ) %>% 
  group_by(item_num) %>% 
  summarize(
    SD = sd(prop_diff, na.rm=T) # a lil hacky
  ) %>% 
  arrange(desc(SD)) %>% 
  head(20) %>% 
  pull(item_num)
  

out <- full_data %>% 
  filter(item_num %in% question_nums)

write_csv(out, "data/hds.csv")


