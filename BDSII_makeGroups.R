# students = seq(1:19)
# students = c('Lexi',
#              'Amanda',
#              'Bridger',
#              'MK',
#              'Matt',
#              'Hunter',
#              'Yu-fan',
#              'Sally',
#              'Anita',
#              'Ming',
#              'Ana',
#              'Natalie',
#              'Manushi',
#              'Isha',
#              'Amir',
#              'Weiyang',
#              'Jacob',
#              'Jordan',
#              'Chloe'
#              )
# groups = list()
# for(i in 1:4){
#   cur_group = sample(students, 3)
#   groups= c(groups, list(cur_group))
#   students = students[! students %in% cur_group]
# }
# 

names <- 
  c(
    "Ana",
    "Anita",
    "Hunter",
    "Isha",
    "Lexi",
    "Chloe",
    "Alan",
    "Natalie",
    "MK",
    "Amanda",
    "Jacob",
    "Matt",
    "Sally",
    "Bridger",
    "Quincy",
    "Amir",
    "Ming",
    "Manushi"
  )

groups <- c(
  rep(1,3),
  rep(2,3),
  rep(3,3),
  rep(4,3),
  rep(5,3),
  rep(6,3)
)

tibble(
  name = names,
  group  = sample(groups)
) %>% 
  arrange(group)
# groups
