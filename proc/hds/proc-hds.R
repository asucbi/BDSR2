library(tidyverse)


make_state_df <- function(fname){
  x <- scan(paste0("harvard dialect survey/", fname), what = "", sep = "\n")
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

fnames <- list.files("harvard dialect survey/")

full_data <- bind_rows(map(fnames, make_state_df))

full_data %>% 
  mutate(
    item_num = str_match(item, "[0-9]+\\. "),
    item = str_replace(item, item_num, ""),
    item_num = str_sub(item_num, 1, -3)
  ) %>% 
  mutate(prop = ans_prop/100) %>% 
  select(state, item_num, item, ans_ind, ans_text, prop)

write_csv(full_data, "hds.csv")
