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

###############################
###############################
#Nyholt, multiple comparisons##
###############################
###############################

nyholt = final_with_er %>%
   select(error_rate, rt, gain, peak_velocity)

A = data.matrix(nyholt, rownames.force = NA)

A<-A[,-1] # delete column 1 - blok
cor_matrix <- cor(A)

es <- eigen(cor_matrix)
var_eig = var(es$values) # -> obtained value =  0.1909774

#the effective number of variables (Meff) may be calculated as follows:
# Meff = 1+ (M-1)(1 - (var_eig/M))
#M = 4 (error_rate, peak_velo, gain, rt)
#var_eig/4 = 0.04774435

#Meff = 1+3*(1 - 0.04774435) = 3.856767


#5/3.856767 = 1.296423~1,3 -  > instead of 95% CI -> 98.7%