
subjects <- read.table("/Users/mplome/dev/STAGE2/Data/full_data_for_2_stage.csv", header = TRUE, sep=",")
View(subjects)

is_correct <- function(row) {
  (row$type == 1 && row$stim_dir == row$sacc_dir) ||
    (row$type == 0 && row$stim_dir != row$sacc_dir);
}

unique_ids <- unique(subjects$sbj_id)
unique_ids

test <- rep(unique_ids, each = 5)
View(test)
testretest <- rep(test, 2)
View(testretest)
#dotad
protocol <- c("p", "a", "a", "a", "p")
tabela <- data.frame(sbj_id=testretest,test_num= rep(1:2, each = length(test)), blok = 1:5, typ = protocol, error =0, correct = 0)

for (i in 1:nrow(subjects)) {
  row = subjects[i,]
  index = tabela$sbj_id==row$sbj_id & tabela$blok == row$block_id & tabela$test_num == row$test_num
  tabela[index,'error'] = tabela[index,'error'] + !is_correct(row)
  tabela[index,'correct'] = tabela[index,'correct'] + is_correct(row)
  tabela[index,'age'] = row$age;
}
------------------------------
#we calculate the mean of saccadic latency for each of subject
for (sbj_id in unique(tabela$sbj_id)) {
  for (b in 1:5) {
    for (tn in 1:2) {
      ti = tabela$sbj_id==sbj_id & tabela$blok==b & tabela$test_num==tn
      si = subjects$sbj_id==sbj_id & subjects$block_id==b & subjects$test_num==tn
      tabela[ti,'rt'] = mean(subjects$sacc_time[si])
      #tabela[ti,'age'] = subjects$age[si][1]
    }
  }
}
---------------------------------------------------
#now we calculate the mean gain for each of subject
for (sbj_id in unique(tabela$sbj_id)) {
  for (b in 1:5) {
    for (tn in 1:2) {
      ti = tabela$sbj_id==sbj_id & tabela$blok==b & tabela$test_num==tn
      si = subjects$sbj_id==sbj_id & subjects$block_id==b & subjects$test_num==tn
      tabela[ti,'gain'] = mean(subjects$gain[si])
      #tabela[ti,'age'] = subjects$age[si][1]
    }
  }
}
------------------------------------------------------------
#now we calculate the mean peak saccadic velocity for each of subject
for (sbj_id in unique(tabela$sbj_id)) {
  for (b in 1:5) {
    for (tn in 1:2) {
      ti = tabela$sbj_id==sbj_id & tabela$blok==b & tabela$test_num==tn
      si = subjects$sbj_id==sbj_id & subjects$block_id==b & subjects$test_num==tn
      tabela[ti,'peak_velocity'] = mean(subjects$peak_velocity[si])
      #tabela[ti,'age'] = subjects$age[si][1]
    }
  }
}

write.csv(tabela, file = '/Users/mplome/dev/STAGE2/Data/full_data_agg.csv', row.names=FALSE)


# library(dplyr)
# koncowa <- najlepsza %>% 
#   group_by(id) %>% 
#   filter(all(error < 3*correct))





