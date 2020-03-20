
#od50 <- read.table("/Users/mplome/data/od50.csv", header = TRUE, sep=",")
subjects <- read.table("/Users/mplome/data/full_data_for_2_stage.csv", header = TRUE, sep=",")


is_correct <- function(row) {
  (row$type == 1 && row$stim_dir == row$sacc_dir) ||
    (row$type == 0 && row$stim_dir != row$sacc_dir);
}

unique_ids <- unique(subjects$sbj_id)
test <- rep(unique_ids, each = 5)
testretest <- rep(test, 2)
protocol <- c("p", "a", "a", "a", "p")
tabela <- data.frame(id=testretest,test_nr= rep(1:2, each = length(test)), blok = 1:5, typ = protocol, error =0, correct = 0)

for (i in 1:nrow(subjects)) {
  row = subjects[i,]
  index = tabela$id==row$sbj_id & tabela$blok == row$block_id & tabela$test_nr == row$test_num
  tabela[index,'error'] = tabela[index,'error'] + !is_correct(row)
  tabela[index,'correct'] = tabela[index,'correct'] + is_correct(row)
  tabela[index,'age'] = row$age;
}

#we calculate the mean of saccadic latency for each of subject
for (id in unique(tabela$id)) {
  for (b in 1:5) {
    for (tn in 1:2) {
      ti = tabela$id==id & tabela$blok==b & tabela$test_nr==tn
      si = subjects$sbj_id==id & subjects$block_id==b & subjects$test_num==tn
      tabela[ti,'rt'] = mean(subjects$sacc_time[si])
      #tabela[ti,'age'] = subjects$age[si][1]
    }
  }
}

#now we calculate the mean gain for each of subject
for (id in unique(tabela$id)) {
  for (b in 1:5) {
    for (tn in 1:2) {
      ti = tabela$id==id & tabela$blok==b & tabela$test_nr==tn
      si = subjects$sbj_id==id & subjects$block_id==b & subjects$test_num==tn
      tabela[ti,'gain'] = mean(subjects$gain[si])
      #tabela[ti,'age'] = subjects$age[si][1]
    }
  }
}

#now we calculate the mean peak saccadic velo for each of subject
for (id in unique(tabela$id)) {
  for (b in 1:5) {
    for (tn in 1:2) {
      ti = tabela$id==id & tabela$blok==b & tabela$test_nr==tn
      si = subjects$sbj_id==id & subjects$block_id==b & subjects$test_num==tn
      tabela[ti,'peak_velocity'] = mean(subjects$peak_velocity[si])
      #tabela[ti,'age'] = subjects$age[si][1]
    }
  }
}
#write.csv(tabela, file = '/Users/mplome/data/aggregated2018.csv', row.names=FALSE)
write.csv(tabela, file = '/Users/mplome/data/et_full_data_agg.csv', row.names=FALSE)

ids <- read.table("/Users/mplome/data/ids2018.csv", header = TRUE, sep=",")
najlepsza <- tabela[tabela$id %in% ids$ids,]

library(dplyr)
koncowa <- najlepsza %>% 
  group_by(id) %>% 
  filter(all(error < 3*correct))

#teraz mamy 21 starych i 21 mlodych
write.csv(koncowa, file = '/Users/mplome/dev/Prosaccades-Antisaccades/Data/koncowa_full_data.csv', row.names=FALSE)

#tabela z 21młodymi i 21starymi, gdzie reaction time nie jest uśrednione do bloków
#subjects2018_eq <- read.table("/Users/mplome/data/subjects2018_eq_100_800.csv", header = TRUE, sep=",")

