library(dplyr)
library(readxl)

table = read.csv("/Users/mplome/dev/STAGE2/Data/raw.csv", 
                     header = TRUE, sep=",")

ids <- read_excel("/Users/mplome/dev/STAGE2/Data/TRT_old.xlsx")

validation = read.csv("/Users/mplome/dev/STAGE2/Data/validation_offset.csv", 
                     header = FALSE, sep="," )
##########################################################################
#merging info about age
table$age = NaN
for (i in 1:nrow(table)) {
  row = table[i,]
  key = paste('A', row$sbj_id, sep="")
  age = as.integer(key %in% ids$Subject)
  table$age[i] = age
}

unique(table$sbj_id[table$age == 0]) #teraz mamy 91 mlodych
unique(table$sbj_id[table$age == 1])  #101 starych, razem 192


################################################################
#reject all that took part in test only (without retest)
test_only = group_by(table,sbj_id, add = FALSE) %>%
  summarise(how_many = n_distinct(test_num))

bad_ids_with_test_only = test_only$sbj_id[test_only$how_many == 1]
#View(bad_ids_with_test_only)
#A5,B2, B8,C4,D7,I0,I2, I8, J3, K8,L5,L8,M2,N4,P4,P5,R5,S3,V5,XX %20 subjects took part only in test
#	<-they only participated once

index = !(table$sbj_id %in% bad_ids_with_test_only)
table = table[index,]

length(unique(table$sbj_id[table$age ==0]))# po usunieciu 80
length(unique(table$sbj_id[table$age ==1])) # po usunieciu 91sstarych
#171 overall
#################################################################
#used before
rejected_ids = c(
  "G0", "P8", # more than 50%errors
  # Young
   "A2", "C0", "C1", "C7",
  #old
  "A0", "A4", "A9", "B0","C2","F3", "F4", 
   "F5", "F6","F9","H0","H6", "L7", "M5", 
  #bad performance, check exclusion criteria -> was done on the aggregated data
  "N6", "Q8"

  ) 

index = !(table$sbj_id %in% rejected_ids)
table = table[index,]

length(unique(table$sbj_id[table$age ==0]))# po usunieciu 75 mlodych
length(unique(table$sbj_id[table$age ==1])) # po usunieciu 74 sstarych/bylo 76, ale 2 wyrzucono
#152 overall ->sample to stage 2
##########################################################################

#VALIDATION PART
validation_data = validation[2:6]
validation_id = validation[1]


# max(1, 2, NaN) -> NaN
max_per_row = apply(validation_data, 1, max)
rows_with_nan = is.nan(max_per_row)
number_of_rows_with_nan = sum(rows_with_nan)

nans_per_row = apply(validation_data, 1, function(x) sum(is.na(x)))
more_than_one_nan = nans_per_row > 1


validation_data_nonan = validation_data
validation_data_nonan[is.na(validation_data)] = 100
bad_per_row = apply(validation_data_nonan, 1, function(x) sum(x > 1))
#more_than_one_bad = bad_per_row > 1
more_than_two_bad = bad_per_row > 2
#View(validation[more_than_two_bad,])

View(validation[more_than_two_bad,]) #these are removed
bad_ids_with_test_prefix = validation_id[more_than_two_bad,]
bad_ids = sapply(bad_ids_with_test_prefix, function(x) substring(x, 2))

index = !(table$sbj_id %in% bad_ids) #here are good ones
final_table = table[index,]

unique(final_table$sbj_id[final_table$age ==1]) #remained ids 
length(unique(final_table$sbj_id[final_table$age ==1]))#73
unique(final_table$sbj_id[final_table$age ==0]) # remained yng ids
length(unique(final_table$sbj_id[final_table$age ==0]))#74 (ale c7 wykluczony bo byl pilotem, czyli 73)
#146

#Before analyzing data we rejected all subjects they had missing as files (>2 blocks/5 blocks missing, ) or hgad poor quality of the validation, as determined/defined (?) in sample exclusion and inclusion criteria. 



################################################################
#################################################################
# #teraz wywalamy najpierw te co braly udzial w pilocie
# rejected_ids = c(
#   # Old
#   "A0", "A4", "A9", "B0","C2","F3", "F4", 
#   "F5", "F6", "F9","H0","H6", "L7", "M5",
#   "N0", "N6", "N9", "U1","V1", "Y0",
#   # Young
#   "A2", "C0", "C1", "C7", "D1", "D3", "D5",
#   "D6", "D8", "E1", "E6", "I1", "I5", "K4",
#   "L4", "N1", "N3", "P0", "Q6", "Q9",
#   # Bad
#   "G0", "P8")
# 
# index = !(final_table$sbj_id %in% rejected_ids)
# final_table = final_table[index,]
# 
# unique(final_table$sbj_id[final_table$age ==1]) # po usunieciu non valid 74 starych
# unique(final_table$sbj_id[final_table$age ==0]) # po usunieciu non valid 62 mlodych


################################################################
#################################################################


write.csv(final_table, file = "/Users/mplome/dev/STAGE2/Data/full_data_for_2_stage.csv", row.names=FALSE)
dim(raw) #86880    11
dim(final_table) #68411    12

length(unique(final_table$sbj_id))









#only for me
#final = 

#  TABELA
#  A B C 
#  -----
#  1 1 2
#  2 3 3
#  1 8 1
#  0 0 1
#
# apply(TABELA, 1, max) -> [max(1,1,2), max(2,3,3), max(1,8,1), max(0,0,1)]
# apply(TABELA, 2, max) -> [max(1,2,1,0), max(1,3,8,0), max(2,3,1,1)]
