library(brms)
library(ggplot2)

#Load the data:
koncowa <- read.table("/Users/mplome/dev/STAGE2/Data/full_data_agg.csv",
                      header = TRUE, sep=",")
koncowa$id <- factor(koncowa$sbj_id)
koncowa$typ <- factor(koncowa$typ)
koncowa$age <- factor(koncowa$age)
koncowa$test_num <- factor(koncowa$test_num)
stary = koncowa[koncowa$age == 1, ]
stary
wektor = stary$rt
mean(wektor)
sd(wektor)
var(wektor)

mlody = koncowa[koncowa$age == 0, ]
mlody
wektor1 = mlody$rt
mean(wektor1)
sd(wektor1)
var(wektor1)



all_pro <- brm(mvbind(rt, gain, peak_velocity) ~1+ age + test_num, data=koncowa)


brms::marginal_effects(all_pro)

plot(all_pro)
summary(all_pro)
brms::pp_check(all_pro)
