library(brms)
library(ggplot2)
library(tidyverse)

#Load the data:
tbl<- read.table("/Users/mplome/dev/STAGE2/Data/full_data_agg.csv",
                      header = TRUE, sep=",")
head(tbl)
tbl$id <- factor(tbl$sbj_id)
tbl$typ <- factor(tbl$typ)
tbl$age <- factor(tbl$age)
tbl$test_num <- factor(tbl$test_num)

final_with_er = tbl %>% 
  group_by(blok) %>% 
  mutate(error_rate =  error/(error+correct))
View(final_with_er)

#final_with_er = write.csv(final_with_er,"/Users/mplome/dev/STAGE2/Data/full_data_agg_with_er.csv" )

all <- brm(mvbind(error_rate, rt, gain, peak_velocity) ~1+ age + typ + (1|sbj_id),
           data = final_with_er)

all <- add_criterion(all, "loo")
summary(all)


brms::marginal_effects(all)
plot(all)
summary(all)
brms::pp_check(all)





