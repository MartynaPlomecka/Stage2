

library(brms)
library(ggplot2)
library(tidyverse)
library(dplyr)

#Load the data:
tbl<- read.table("/Users/mplome/dev/STAGE2/Data/full_data_agg.csv",
                      header = TRUE, sep=",")
#changing the predictors for factors
tbl$id <- factor(tbl$sbj_id)
tbl$typ <- factor(tbl$typ)                
tbl$age <- factor(tbl$age)
tbl$test_num <- factor(tbl$test_num)

final_with_er = tbl %>% 
  group_by(blok) %>% 
  mutate(error_rate =  error/(error+correct))
View(final_with_er)


#priors were determined in the stag1 RR
prior<-c(set_prior("cauchy(0, 10)",class = "b", coef = ""),set_prior("cauchy(0, 10)", class = "Intercept", coef = ""))

#multiv.model
all <- brm(mvbind(error_rate, rt, gain, peak_velocity) ~1+ age *typ + (1|sbj_id),
          prior = prior, data = final_with_er)


summ = summary(all, priors = TRUE, prob = 0.987) #after correcting for multiple comparisons with the nyholt approach, for details see:Stats ->Nyholt


brms::conditional_effects(all)

brms::marginal_effects(all)
plot(all)
summary(all)
brms::pp_check(all, resp = "rt")
brms::pp_check(all, resp = "errorrate")
brms::pp_check(all, resp = "peakvelocity")
brms::pp_check(all, resp = "gain")


