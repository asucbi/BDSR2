students = seq(1:12)
students = c('Ayah',
             'Matt',
             'Allison',
             'Rose',
             'Kristen',
             'Megan',
             'Taylor',
             'Yasaman',
             'Alex',
             'Natalie',
             'Emma',
             'Gabby'
             )
groups = list()
for(i in 1:4){
  cur_group = sample(students, 3)
  groups= c(groups, list(cur_group))
  students = students[! students %in% cur_group]
}

groups
