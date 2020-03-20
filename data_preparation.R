
validation = read.csv("/Users/mplome/dev/Stage_2_Submission/validation_offset.csv", 
                     header = FALSE, sep="," )
validation_data = validation[2:6]
validation_id = validation[1]


table = read.csv("/Users/mplome/data/full_data_for_2_stage.csv", 
                     header = TRUE, sep=",")


final = 

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

# max(1, 2, NaN) -> NaN
max_per_row = apply(validation_data, 1, max)
rows_with_nan = is.nan(max_per_row)
number_of_rows_with_nan = sum(rows_with_nan)

nans_per_row = apply(validation_data, 1, function(x) sum(is.na(x)))
more_than_one_nan = nans_per_row > 2


validation_data_nonan = validation_data
validation_data_nonan[is.na(validation_data)] = 100
bad_per_row = apply(validation_data_nonan, 1, function(x) sum(x > 1))
more_than_one_bad = bad_per_row > 1
more_than_two_bad = bad_per_row > 2
#View(validation[more_than_two_bad,])

bad_ids_with_test_prefix = validation_id[more_than_one_bad,]
bad_ids = sapply(bad_ids_with_test_prefix, function(x) substring(x, 2))

index = !(table$sbj_id %in% bad_ids)
final_table = table[index,]


length(final_table)
