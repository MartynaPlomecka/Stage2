#prosacc -2
#anti -1
library("brms")
library(ggplot2)
library(tidyverse)
library(dplyr)

#Load the data
prosa = read.csv("~/dev/STAGE2/prosa.csv")
seria = read.csv("~/dev/STAGE2/seria.csv")

# condition: 1 (anti), 2 (pro)
seria_anti = seria[seria$conditions == 1,]
seria_pro = seria[seria$conditions == 2,]
head(seria)
seria$conditions<-factor(seria$conditions, levels = c(1,2), labels = c(0,1))

# condition: 1 (anti), 2 (pro)
prosa_anti = prosa[prosa$conditions == 1,]
prosa_pro = prosa[prosa$conditions == 2,]
head(prosa)
prosa$conditions<-factor(prosa$conditions, levels = c(1,2), labels = c(0,1))

#zmienione 1->0, teraz antisaccady sa 0
#zmienione 2->1, teraz antisaccady sa 1
prosa$conditions <- factor(prosa$conditions)
prosa$age <- factor(prosa$age)

#zmienione 1->0, teraz antisaccady sa 0
#zmienione 2->1, teraz antisaccady sa 1
seria$conditions <- factor(seria$conditions)
seria$age <- factor(seria$age)

#############MODELS
prosa_all <- brm(mvbind(inhib_fail_prob,inhib_fail_rt,predicted_pro_rt,predicted_anti_rt) ~1+ age *conditions,data = prosa)
summary(prosa_all)

seria_all <- brm(mvbind(late_pro_prob,inhib_fail_prob,late_pro_rt,inhib_fail_rt,predicted_pro_rt,predicted_anti_rt) ~1+ age * conditions,data = seria)
summary(seria_all)



####meaningful
prosa_m <- brm(mvbind(inhib_fail_prob,inhib_fail_rt) ~1+ age *conditions,data = prosa)
summary(prosa_m)
#plot(prosa_m)
seria_m <- brm(mvbind(late_pro_prob,inhib_fail_prob,late_pro_rt,inhib_fail_rt) ~1+ age * conditions,data = seria)
summary(seria_m)




#####try
hist(seria$inhib_fail_prob)#inv gamma
hist(seria$inhib_fail_rt)#gauss
hist(seria$late_pro_prob)#inv gamma z dwoch stron
hist(seria$late_pro_rt)#gauss
hist(seria_anti$late_pro_prob) #-> a wiec duze prawd dla anty
