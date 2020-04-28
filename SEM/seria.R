#seriacc -2
#anti -1
library("brms")
library(ggplot2)
library(tidyverse)
library(dplyr)


#Load the data
seria = read.csv("~/dev/STAGE2/seria.csv")

# condition: 1 (anti), 2 (pro)
anti = seria[seria$conditions == 1,]
pro = seria[seria$conditions == 2,]
head(seria)
seria$conditions<-factor(seria$conditions, levels = c(1,2), labels = c(0,1))

#zmienione 1->0, teraz antisaccady sa 0
#zmienione 2->1, teraz antisaccady sa 1
seria$conditions <- factor(seria$conditions)
seria$age <- factor(seria$age)

seria <- brm(mvbind(late_pro_prob,inhib_fail_prob,late_pro_rt,anti_rt,inhib_fail_rt,predicted_pro_rt,predicted_pro_prob,predicted_anti_rt,predicted_anti_prob) ~1+ age *conditions,data = seria)

#i removed random effect, is it fine?


