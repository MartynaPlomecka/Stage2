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
###############################################################################################

########Reaction time############

####################################
############old#####################
####################################
#test
mprotestoldagg = protestoldagg %>%
  group_by(sbj_id)%>%
  summarise(mean_rt = mean(rt))

mantitestoldagg = antitestoldagg %>%
  group_by(sbj_id)%>%
  summarise(mean_rt = mean(rt))
#retest
mproretestoldagg = proretestoldagg %>%
  group_by(sbj_id)%>%
  summarise(mean_rt = mean(rt))

mantiretestoldagg = antiretestoldagg %>%
  group_by(sbj_id)%>%
  summarise(mean_rt = mean(rt))
####################################
############yng#####################
####################################
#test
mprotestyngagg = protestyngagg %>%
  group_by(sbj_id)%>%
  summarise(mean_rt = mean(rt))

mantitestyngagg = antitestyngagg %>%
  group_by(sbj_id)%>%
  summarise(mean_rt = mean(rt))
#retest
mproretestyngagg = proretestyngagg %>%
  group_by(sbj_id)%>%
  summarise(mean_rt = mean(rt))

mantiretestyngagg = antiretestyngagg %>%
  group_by(sbj_id)%>%
  summarise(mean_rt = mean(rt))


#####ICC
#old
rprotrtoldagg <- merge(mprotestoldagg,  mproretestoldagg, by = c("sbj_id"))
riccprotrtoldagg = icc(type = "agreement", ratings = (rprotrtoldagg[, c(2,3)]))
riccprotrtoldagg
 
rantitrtoldagg <- merge(mantitestoldagg,  mantiretestoldagg, by = c("sbj_id"))
riccantitrtoldagg = icc(type = "agreement", ratings = (rantitrtoldagg[, c(2,3)]))
riccantitrtoldagg
#yng
rprotrtyngagg <- merge(mprotestyngagg,  mproretestyngagg, by = c("sbj_id"))
riccprotrtyngagg = icc(type = "agreement", ratings = (rprotrtyngagg[, c(2,3)]))
riccprotrtyngagg
 
rantitrtyngagg <- merge(mantitestyngagg,  mantiretestyngagg, by = c("sbj_id"))
riccantitrtyngagg = icc(type = "agreement", ratings = (rantitrtyngagg[, c(2,3)]))
riccantitrtyngagg



