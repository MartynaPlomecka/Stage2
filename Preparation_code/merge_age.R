#for later
# define cut offs
#subjects_100_800 = subjects[(subjects$sacc_time>100 )& (subjects$sacc_time<800) , ]
#subjects_100_800


#20.03 - wsszytsko dziala, wiek sie merguje odpowiednip
library(readxl)


table <- read.table("/Users/mplome/data/full_data_for_2_stage.csv", header = TRUE, sep=",")

ids <- read_excel("/Users/mplome/dev/STAGE2/TRT_old.xlsx")

table$age = NaN
for (i in 1:nrow(table)) {
  row = table[i,]
  key = paste('A', row$sbj_id, sep="")
  age = as.integer(key %in% ids$Subject)
  table$age[i] = age
}


unique(table$age)
unique(table$sbj_id)

# ids <- read.table("/Users/mplome/dev/STAGE2/TRT_old.xlsx", header = TRUE, sep=",")

# table$age = NaN
# for (i in 1:nrow(table)) {
#   row = table[i,]
#   key = paste('A', row$sbj_id, sep="")
#   age = ids[ids$Subject == key,2]
#   table$age[i] = age
# }

write.csv(table, file = "/Users/mplome/dev/STAGE2/full_data_for_2_stage.csv", row.names=FALSE)


