

library(ggplot2)
library(grid)
library(gridExtra)
library(lattice)

table = read.csv("/Users/mplome/dev/STAGE2/Data/full_data_for_2_stage.csv")

val_ecdf <- function(x){
  my_ecdf <- ecdf(x)
  return(my_ecdf(x))
}

#empirical cdf
my_ecdf = ecdf(table$sacc_time)
plot(my_ecdf)


library(ggplot2) 
theme_set(theme_minimal())

###tutaj moje
anty_old_1_x =  table$sacc_time[(table$type==0)& (table$age==1) & (table$stim_dir == table$sacc_dir)]
anty_old_0_x=  table$sacc_time[(table$type==0)& (table$age==1) & (table$stim_dir != table$sacc_dir)]
pro_old_1_x = table$sacc_time[(table$type==1)& (table$age==1) & (table$stim_dir != table$sacc_dir)]
pro_old_0_x =  table$sacc_time[(table$type==1)& (table$age==1) & (table$stim_dir == table$sacc_dir)]
anty_young_1_x =  table$sacc_time[(table$type==0)& (table$age==0) & (table$stim_dir == table$sacc_dir)]
anty_young_0_x =  table$sacc_time[(table$type==0)& (table$age==0) & (table$stim_dir != table$sacc_dir)]
pro_young_1_x = table$sacc_time[(table$type==1)&(table$age==0) & (table$stim_dir != table$sacc_dir)]
pro_young_0_x = table$sacc_time[(table$type==1) & (table$age==0) & (table$stim_dir == table$sacc_dir)]
######

qqnorm(table$sacc_time[(table$type==1)& (table$age==1) & (table$stim_dir != table$sacc_dir)]
)


dfo = rbind(
  data.frame(x=unlist(density(pro_old_0_x)[1]), y=unlist(density(pro_old_0_x)[2])*length(pro_old_0_x)/nrow(table), old='prosaccades'),
  data.frame(x=unlist(density(anty_old_0_x)[1]), y=unlist(density(anty_old_0_x)[2])*length(anty_old_0_x)/nrow(table), old='correct antisaccades'),
  data.frame(x=unlist(density(anty_old_1_x)[1]), y=unlist(density(anty_old_1_x)[2])*length(anty_old_1_x)/nrow(table), old='error antisaccades')
)

dfy = rbind(
  data.frame(x=unlist(density(pro_young_0_x)[1]), y=unlist(density(pro_young_0_x)[2])*length(pro_young_0_x)/nrow(table), young='prosaccades'),
  data.frame(x=unlist(density(anty_young_0_x)[1]), y=unlist(density(anty_young_0_x)[2])*length(anty_young_0_x)/nrow(table), young='correct antisaccades'),
  data.frame(x=unlist(density(anty_young_1_x)[1]), y=unlist(density(anty_young_1_x)[2])*length(anty_young_1_x)/nrow(table), young='error antisaccades')
)

df2o = rbind(
  data.frame(x=pro_old_0_x, y=qnorm(val_ecdf(pro_old_0_x)), old='prosaccades'),
  data.frame(x=anty_old_0_x, y=qnorm(val_ecdf(anty_old_0_x)*length(anty_old_0_x)/(length(anty_old_0_x) + length(anty_old_1_x))), old='correct antisaccades'),
  data.frame(x=anty_old_1_x, y=qnorm(val_ecdf(anty_old_1_x)*length(anty_old_1_x)/(length(anty_old_0_x) + length(anty_old_1_x))), old='error antisaccades')
)

df2y = rbind(
  data.frame(x=pro_young_0_x, y=qnorm(val_ecdf(pro_young_0_x)), young='prosaccades'),
  data.frame(x=anty_young_0_x, y=qnorm(val_ecdf(anty_young_0_x)*length(anty_young_0_x)/(length(anty_young_0_x) + length(anty_young_1_x))),young='correct antisaccades'),
  data.frame(x=anty_young_1_x, y=qnorm(val_ecdf(anty_young_1_x)*length(anty_young_1_x)/(length(anty_young_0_x) + length(anty_young_1_x))), young='error antisaccades')
)





#################
b = ggplot(dfo, aes(x))+
  geom_jitter(aes(y = y, color = old, size = 14), , alpha = 0.99, size = 0.6, show.legend = FALSE) + 
  xlab("") + ylab("") +
  theme_bw() +
  theme(legend.title = element_text(size = 14), legend.text = element_text(size = 14)) +
  theme(axis.text = element_text(size = 18),
        axis.title = element_text(size = 21)) +
  ylim(0, 0.0020)
b

##################


a1 = ggplot(dfy, aes(x)) +
  geom_jitter(aes(y = y, color = young), alpha = 0.99, size = 0.6) + 
  xlab("") + ylab("probability") +
  xlim(0,800) +
  ylim(0, 0.0020) +
  theme_bw() +
  #theme(panel.grid = element_blank()) +
  theme(legend.title = element_blank(), legend.text = element_text(size = 21)) +
  theme(legend.position="bottom") +
  theme(legend.background = element_rect(size=0.5, linetype="solid", colour ="black")) +
  theme(axis.text = element_text(size = 18),
        axis.title = element_text(size = 21)) +
  guides(colour = guide_legend(override.aes = list(size=7)))

a = a1 + theme(legend.position = 'none')
a
#################
probs = c(0.001, 0.01, 0.1, 1, 50, 99, 99.99)

zs = qnorm(probs/100)

c  = ggplot(df2y, aes(x))+
  geom_jitter(aes(y = y, color =young, fontsize = 21), alpha = 0.99, size = 0.6, show.legend = FALSE) +
  xlab("reaction time (ms)") + 
  ylab(" cumulative probability") +
  theme_bw() +
  theme(legend.title = element_text(size = 14), legend.text = element_text(size = 14)) +
scale_y_continuous(labels=paste(as.character(probs), "%", sep =""), breaks = zs) +
  theme(axis.text = element_text(size = 18),
        axis.title = element_text(size = 21))
c

d  = ggplot(df2o, aes(x))+
geom_jitter(aes(y = y, color = old, fontsize = 21), alpha = 0.99, size = 0.6, show.legend = FALSE) + 
  xlab("reaction time (ms)") + 
  ylab("") + 
  theme_bw() +
  theme(axis.text = element_text(size = 16),
        axis.title = element_text(size = 21)) +
  theme(legend.title = element_text(size = 14), legend.text = element_text(size = 14)) +
  scale_y_continuous(labels=paste(as.character(probs), "%", sep =""), breaks = zs)
d
####W############

p1 = grid.arrange(a, c, ncol = 1, top=textGrob("Young Group", gp=gpar(fontsize = 24,font=8,face="bold" )))


p2= grid.arrange(b, d, ncol = 1,top=textGrob("Old Group", gp=gpar(fontsize=24,font=8 ,face="bold")))

    
all = grid.arrange(p1, p2,  ncol=2)
all

g_legend<-function(a.gplot){
  tmp <- ggplot_gtable(ggplot_build(a.gplot))
  leg <- which(sapply(tmp$grobs, function(x) x$name) == "guide-box")
  legend <- tmp$grobs[[leg]]
  return(legend)}

mylegend<-g_legend(a1)

p3 <- grid.arrange(arrangeGrob(p1, p2, nrow=1),
                   mylegend, nrow=2,heights=c(10, 1))
p3
