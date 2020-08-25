#ICC for error rate 
library(dplyr)
library(irr)
#load data
table_agg = read.csv("/Users/mplome/dev/STAGE2/Data/full_data_agg.csv")
head(table_agg)
oldagg = table_agg[table_agg$age==1,]
yngagg= table_agg[table_agg$age==0,]

#old
protestoldagg = oldagg[oldagg$typ=="p" & oldagg$test_num==1, ]
antitestoldagg = oldagg[oldagg$typ=="a" & oldagg$test_num==1, ]
proretestoldagg = oldagg[oldagg$typ=="p" & oldagg$test_num==2, ]

antiretestoldagg = oldagg[oldagg$typ=="a" & oldagg$test_num==2, ]

#yng
protestyngagg = yngagg[yngagg$typ=="p" & yngagg$test_num==1, ]
antitestyngagg = yngagg[yngagg$typ=="a" & yngagg$test_num==1, ]
proretestyngagg = yngagg[yngagg$typ=="p" & yngagg$test_num==2, ]
antiretestyngagg = yngagg[yngagg$typ=="a" & yngagg$test_num==2, ]

####################################
############old#####################
####################################
#test
mprotestoldagg = protestoldagg %>%
  group_by(sbj_id)%>%
  summarise(sum_error = sum(error))

mantitestoldagg = antitestoldagg %>%
  group_by(sbj_id)%>%
  summarise(sum_error = sum(error))
#retest
mproretestoldagg = proretestoldagg %>%
  group_by(sbj_id)%>%
  summarise(sum_error = sum(error))

mantiretestoldagg = antiretestoldagg %>%
  group_by(sbj_id)%>%
  summarise(sum_error = sum(error))

####################################
############yng#####################
####################################
#test
mprotestyngagg = protestyngagg %>%
  group_by(sbj_id)%>%
  summarise(sum_error = sum(error))

mantitestyngagg = antitestyngagg %>%
  group_by(sbj_id)%>%
  summarise(sum_error = sum(error))
#retest
mproretestyngagg = proretestyngagg %>%
  group_by(sbj_id)%>%
  summarise(sum_error = sum(error))

mantiretestyngagg = antiretestyngagg %>%
  group_by(sbj_id)%>%
  summarise(sum_error = sum(error))

######################preparation error rate#icc 1 from wiki
eprotrtoldagg <- merge(mprotestoldagg,  mproretestoldagg, by = c("sbj_id"))

eiccprotrtoldagg = icc(type = "agreement", ratings = (eprotrtoldagg[, c(2,3)]))
eiccprotrtoldagg

eantitrtoldagg <- merge(mantitestoldagg,  mantiretestoldagg, by = c("sbj_id"))
eiccantitrtoldagg = icc(type = "agreement", ratings = (eantitrtoldagg[, c(2,3)]))
eiccantitrtoldagg

eprotrtyoungagg <- merge(mprotestyngagg,  mproretestyngagg, by = c("sbj_id"))
eiccprotrtyoungagg = icc(type = "agreement", ratings = (eprotrtyoungagg[, c(2,3)]))
eiccprotrtyoungagg

eantitrtyoungagg <- merge(mantitestyngagg, mantiretestyngagg, by = c("sbj_id"))
eiccantitrtyoungagg = icc(type = "agreement", ratings = (eantitrtyoungagg[, c(2,3)]))
eiccantitrtyoungagg
