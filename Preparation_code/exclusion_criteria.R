library(dplyr)
table_agg = read.csv('/Users/mplome/dev/STAGE2/Data/full_data_agg.csv', 
                     header = TRUE, sep=",")

table = read.csv('/Users/mplome/dev/STAGE2/Data/full_data_for_2_stage.csv', 
                     header = TRUE, sep=",")
################################################################
################################################################

#trial exclusion criteria based on length
# define cut offs ->50 & 800
table = table[(table$sacc_time>50 )& (table$sacc_time<800) , ]
#sanity check : table[(table$sacc_time<50),]
write.csv(table, file = '/Users/mplome/dev/STAGE2/Data/full_data_for_2_stage.csv', row.names=FALSE)
dim(table)
69120-66075
################################################################
################################################################

#subjects exclusion criteria based on bad performance

# blocks with more than 50%errors
 df <- table_agg %>% 
   filter((error < correct))


 #if I rmoved more than 2 blocks the whole subject should be also removed
final <-df%>% 
  group_by(sbj_id, test_num) %>%
  filter(n() > 2)

#now I need to check if after the last change, there is a subject with 1 timepoint only


test = group_by(final,sbj_id, add = FALSE) %>%
  summarise(how_many = n_distinct(test_num))

bad_ids_with_test_only = test$sbj_id[test$how_many == 1]
View(bad_ids_with_test_only) #N6, Q8


reject_ids = c("N6", "Q8","B3") 

index_good = !(final$sbj_id %in% reject_ids)
final = final[index_good,]

length(unique(final$sbj_id[final$age ==0]))# po usunieciu 73 mlodych
length(unique(final$sbj_id[final$age ==1])) # po usunieciu 70 sstarych


#143 overall ->sample to stage 2
write.csv(final, file = '/Users/mplome/dev/STAGE2/Data/full_data_agg.csv', row.names=FALSE)


