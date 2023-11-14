library(tidyverse)

# data comes from fec.gov
# https://www.fec.gov/introduction-campaign-finance/election-results-and-voting-information/
# required some manual renaming to load nicely

d <- list.files(path = "data/", pattern = "\\.xlsx$", full.names=T) %>% 
  map_df(
    ~readxl::read_xlsx(., sheet = "US House Results by State") %>% 
      select(STATE, DISTRICT, `CANDIDATE NAME`, PARTY, `GENERAL VOTES`, `GENERAL %`, `GE WINNER INDICATOR`) %>% 
      filter(!is.na(`GENERAL VOTES`)) %>% 
      mutate(year = gsub(".xlsx", "", gsub("data//federalelections", "", .x, )))
  )

out <- d %>% 
  rename(
    state = STATE,
    district = DISTRICT,
    candidate = `CANDIDATE NAME`,
    party = PARTY,
    votes = `GENERAL VOTES`,
    prop = `GENERAL %`,
    winner = `GE WINNER INDICATOR`
  ) %>% 
  drop_na(
    candidate
  ) %>% 
  filter(candidate != "Scattered", state != "American Samoa") %>% 
  mutate(
    winner = ifelse(is.na(winner), 0, 1)
  ) %>% 
  mutate_at(vars(district, year, votes), as.integer)
  


write_csv(out, "../../data/congress.csv")
