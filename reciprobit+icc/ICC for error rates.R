#tuttaj irr tylko dla error rate

library(dplyr)
library(irr)
#load data
najlepszaagg = read.csv("/Users/mplome/dev/STAGE2/full_data_agg.csv")
head(najlepszaagg)
oldagg = najlepszaagg[najlepszaagg$age==1,]
youngagg= najlepszaagg[najlepszaagg$age==0,]

head(youngagg)
head(oldagg)
######################preparation error rate#icc 1 z wikipedii
eprotestoldagg = oldagg[oldagg$typ=="p" & oldagg$test_num==1, c("sbj_id", "error")]   
eproretestoldagg = oldagg[oldagg$typ=="p" &oldagg$test_num==2, c("sbj_id", "error")] 
eprotrtoldagg <- merge(eprotestoldagg,  eproretestoldagg, by = c("sbj_id"))
eiccprotrtoldagg = icc(type = "agreement", ratings = (eprotrtoldagg[, c(2,3)]))
eiccprotrtoldagg


eantitestoldagg= oldagg[oldagg$typ=="a" &oldagg$test_num==1, c("sbj_id", "error") ]   
eantiretestoldagg= oldagg[oldagg$typ=="a" &oldagg$test_num==2, c("sbj_id", "error")] 
eantitrtoldagg <- merge(eantitestoldagg,  eantiretestoldagg, by = c("sbj_id"))
eiccantitrtoldagg = icc(type = "agreement", ratings = (eantitrtoldagg[, c(2,3)]))
eiccantitrtoldagg

eprotestyoungagg= youngagg[youngagg$typ=="p" &youngagg$test_num==1, c("sbj_id", "error") ]   
eproretestyoungagg= youngagg[youngagg$typ=="p" &youngagg$test_num==2, c("sbj_id", "error")] 
eprotrtyoungagg <- merge(eprotestyoungagg,  eproretestyoungagg, by = c("sbj_id"))
eiccprotrtyoungagg = icc(type = "agreement", ratings = (eprotrtyoungagg[, c(2,3)]))
eiccprotrtyoungagg

eantitestyoungagg= youngagg[youngagg$typ=="a" &youngagg$test_num==1, c("sbj_id", "error") ]   
eantiretestyoungagg= youngagg[youngagg$typ=="a" & youngagg$test_num==2, c("sbj_id", "error")] 
eantitrtyoungagg <- merge(eantitestyoungagg, eantiretestyoungagg, by = c("sbj_id"))
eiccantitrtyoungagg = icc(type = "agreement", ratings = (eantitrtyoungagg[, c(2,3)]))


eiccantitrtyoungagg
