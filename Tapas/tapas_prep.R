
subjects <- read.table("/Users/mplome/dev/STAGE2/full_data_agg.csv", header = TRUE, sep=",")
head(subjects)

subjects_old = subjects[subjects$age==1,]

subjects_yng = subjects[subjects$age==0,]

View(subjects_yng)

write.csv(subjects_yng, file = "/Users/mplome/dev/STAGE2/subjects_yng_agg.csv", row.names=FALSE)

write.csv(subjects_old, file = "/Users/mplome/dev/STAGE2/subjects_old_agg.csv", row.names=FALSE)

##############preparation for SEM

tapas_old  <- subset(subjects_old, select = -c(test_num, blok,  ) )
