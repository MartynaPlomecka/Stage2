
library(dplyr)
library(ggplot2)
library(gridGraphics)
library(gridBase)
library(gridExtra)
library(grid)

final <- read.table("/Users/mplome/dev/STAGE2/Data/full_data_for_2_stage.csv",
                    header = TRUE, sep=",")

create_ggplot <- function(proold1t, proold2t, antiold1t, antiold2t,
                          proyoung1t, proyoung2t, antiyoung1t, antiyoung2t,
                          title, xlimits, ylimits) {
  df_plot = rbind(
    data.frame(test=proold1t, retest=proold2t, age='old', type='pro'),
    data.frame(test=antiold1t, retest=antiold2t, age='old', type='anti'),
    data.frame(test=proyoung1t, retest=proyoung2t, age='young', type='pro'),
    data.frame(test=antiyoung1t, retest=antiyoung2t, age='young', type='anti')
  )
  
  ggplot(df_plot, aes(x=test, y=retest)) +
    geom_point(aes(color=type, shape=age), size=2) +
    xlim(xlimits[1], xlimits[2]) +
    ylim(ylimits[1], ylimits[2]) +
    ggtitle(title) +
    geom_abline()+
    theme_bw() +
    theme(panel.background = element_rect(fill = "white", colour = "grey50"),
          plot.title = element_text(size=20)) +
    theme(legend.text = element_text(size = 17)) +
    theme(legend.title = element_text(size = 20)) +
    theme(axis.text = element_text(size = 17),
          axis.title = element_text(size = 20)) +
    guides(colour = guide_legend(override.aes = list(size=4)),
           shape = guide_legend(override.aes = list(size=4)))
}



############
icc = final %>% group_by(sbj_id, age,type, test_num) %>% summarise(avg=median(peak_velocity))


proold = icc[icc$age ==1 & icc$type==1, ]
proyoung = icc[icc$age ==0 & icc$type==1, ]
antiold = icc[icc$age==1 & icc$type==0, ]
antiyoung = icc[icc$age==0 & icc$type==0, ]

proold1 = icc[icc$age ==1 & icc$type==1 & icc$test_num==1, ]
proyoung1 = icc[icc$age ==0 & icc$type==1 & icc$test_num==1, ]
antiold1 = icc[icc$age==1 & icc$type==0 & icc$test_num==1, ]
antiyoung1 = icc[icc$age==0 & icc$type==0 & icc$test_num==1, ]

proold2 = icc[icc$age ==1 & icc$type==1 & icc$test_num==2, ]
proyoung2 = icc[icc$age ==0 & icc$type==1 & icc$test_num==2, ]
antiold2 = icc[icc$age==1 & icc$type==0 & icc$test_num==2, ]
antiyoung2 = icc[icc$age==0 & icc$type==0 & icc$test_num==2, ]

proold1t = proold1$avg
proyoung1t = proyoung1$avg
antiold1t = antiold1$avg
antiyoung1t = antiyoung1$avg

proold2t = proold2$avg
proyoung2t = proyoung2$avg
antiold2t = antiold2$avg
antiyoung2t = antiyoung2$avg




a = create_ggplot(proold1t, proold2t, antiold1t, antiold2t,
                  proyoung1t, proyoung2t, antiyoung1t, antiyoung2t,
                  'Peak Velocity', c(200,400), c(200,400))



#############
#reaction time
############

icc = final %>% group_by(sbj_id, age,type, test_num) %>% summarise(avg=median(sacc_time))


proold = icc[icc$age ==1 & icc$type==1, ]
proyoung = icc[icc$age ==0 & icc$type==1, ]
antiold = icc[icc$age==1 & icc$type==0, ]
antiyoung = icc[icc$age==0 & icc$type==0, ]


proold1 = icc[icc$age ==1 & icc$type==1 & icc$test_num==1, ]
proyoung1 = icc[icc$age ==0 & icc$type==1 & icc$test_num==1, ]
antiold1 = icc[icc$age==1 & icc$type==0 & icc$test_num==1, ]
antiyoung1 = icc[icc$age==0 & icc$type==0 & icc$test_num==1, ]

proold2 = icc[icc$age ==1 & icc$type==1 & icc$test_num==2, ]
proyoung2 = icc[icc$age ==0 & icc$type==1 & icc$test_num==2, ]

antiold2 = icc[icc$age==1 & icc$type==0 & icc$test_num==2, ]
antiyoung2 = icc[icc$age==0 & icc$type==0 & icc$test_num==2, ]


proold1t = proold1$avg
proyoung1t = proyoung1$avg
antiold1t = antiold1$avg
antiyoung1t = antiyoung1$avg

proold2t = proold2$avg
proyoung2t = proyoung2$avg
antiold2t = antiold2$avg
antiyoung2t = antiyoung2$avg


b = create_ggplot(proold1t, proold2t, antiold1t, antiold2t,
                  proyoung1t, proyoung2t, antiyoung1t, antiyoung2t,
                  'Reaction Time', c(200,450), c(200,450))





########
# gain
#######
final <- read.table("/Users/mplome/dev/STAGE2/Data/full_data_for_2_stage.csv",
                      header = TRUE, sep=",")

icc = final %>% group_by(sbj_id, age,type, test_num) %>% summarise(avg=mean(gain))

proold = icc[icc$age ==1 & icc$type==1, ]
proyoung = icc[icc$age ==0 & icc$type==1, ]
antiold = icc[icc$age==1 & icc$type==0, ]
antiyoung = icc[icc$age==0 & icc$type==0, ]


proold1 = icc[icc$age ==1 & icc$type==1 & icc$test_num==1, ]
proyoung1 = icc[icc$age ==0 & icc$type==1 & icc$test_num==1, ]
antiold1 = icc[icc$age==1 & icc$type==0 & icc$test_num==1, ]
antiyoung1 = icc[icc$age==0 & icc$type==0 & icc$test_num==1, ]

proold2 = icc[icc$age ==1 & icc$type==1 & icc$test_num==2, ]
proyoung2 = icc[icc$age ==0 & icc$type==1 & icc$test_num==2, ]
antiold2 = icc[icc$age==1 & icc$type==0 & icc$test_num==2, ]
antiyoung2 = icc[icc$age==0 & icc$type==0 & icc$test_num==2, ]


proold1t = proold1$avg
proyoung1t = proyoung1$avg
antiold1t = antiold1$avg
antiyoung1t = antiyoung1$avg

proold2t = proold2$avg
proyoung2t = proyoung2$avg
antiold2t = antiold2$avg
antiyoung2t = antiyoung2$avg


c = create_ggplot(proold1t, proold2t, antiold1t, antiold2t,
                  proyoung1t, proyoung2t, antiyoung1t, antiyoung2t,
                  'Gain', c(0.5,1.0), c(0.5,1.0))



##############
###Error rate
##############

final <- read.table("/Users/mplome/dev/STAGE2/Data/full_data_for_2_stage.csv",
                      header = TRUE, sep=",")
final$error_rate = final$error / (final$error + final$correct)
head(final)
icc = final %>% group_by(id,blok, age,typ, test_nr) %>% summarise(avg=mean(error_rate))

#colnames(icc) = c("sbj_id", "age", "typ", "test_nr", "avg")
icc$typ[icc$typ=='0'] = 'a'
icc$typ[icc$typ=='1'] = 'p'

proold = icc[icc$age ==1 & icc$typ=="p", ]
proyoung = icc[icc$age ==0 & icc$typ=="p", ]
antiold = icc[icc$age==1 & icc$typ=="a", ]
antiyoung = icc[icc$age==0 & icc$typ=="a", ]


proold1 = icc[icc$age ==1 & icc$typ=="p" & icc$test_nr==1, ]
proyoung1 = icc[icc$age ==0 & icc$typ=="p" & icc$test_nr==1, ]
antiold1 = icc[icc$age==1 & icc$typ=="a" & icc$test_nr==1, ]
antiyoung1 = icc[icc$age==0 & icc$typ=="a" & icc$test_nr==1, ]

proold2 = icc[icc$age ==1 & icc$typ=="p" & icc$test_nr==2, ]
proyoung2 = icc[icc$age ==0 & icc$typ=="p"  & icc$test_nr==2, ]
antiold2 = icc[icc$age==1 & icc$typ=="a" & icc$test_nr==2, ]
antiyoung2 = icc[icc$age==0 & icc$typ== "a" & icc$test_nr==2, ]


proold1t = proold1$avg
proyoung1t = proyoung1$avg
antiold1t = antiold1$avg
antiyoung1t = antiyoung1$avg

proold2t = proold2$avg
proyoung2t = proyoung2$avg
antiold2t = antiold2$avg
antiyoung2t = antiyoung2$avg


#####

d = create_ggplot(proold1t, proold2t, antiold1t, antiold2t,
                  proyoung1t, proyoung2t, antiyoung1t, antiyoung2t,
                  'Error Rate', c(0.,0.4), c(0.,0.4))





grid = grid.arrange(b + theme(legend.position = 'none'),
                    d + theme(legend.position = 'none'),
                    c + theme(legend.position = 'none'),
                    a + theme(legend.position = 'none'),
                    ncol=2, nrow=2)



g_legend<-function(a.gplot){
  tmp <- ggplot_gtable(ggplot_build(a.gplot))
  leg <- which(sapply(tmp$grobs, function(x) x$name) == "guide-box")
  legend <- tmp$grobs[[leg]]
  return(legend)}

mylegend<-g_legend(a)

p3 <- grid.arrange(grid,
                   mylegend, ncol=2,widths=c(10, 1))


