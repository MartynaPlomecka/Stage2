library(dplyr)
library(irr)
#load data
najlepszaagg = read.csv("/Users/mplome/dev/STAGE2/full_data_agg.csv")
head(najlepszaagg)
oldagg = najlepszaagg[najlepszaagg$age==1,]
youngagg= najlepszaagg[najlepszaagg$age==0,]

#####RT, raczej tak wolimy
rprotestoldagg= oldagg[oldagg$typ=="p" &oldagg$test_num==1, c("sbj_id", "rt") ]   
rproretestoldagg= oldagg[oldagg$typ=="p" &oldagg$test_num==2, c("sbj_id", "rt")] 
rprotrtoldagg <- merge(rprotestoldagg,  rproretestoldagg, by = c("sbj_id"))
riccprotrtoldagg = icc(type = "agreement", ratings = (rprotrtoldagg[, c(2,3)]))
riccprotrtoldagg

rantitestoldagg= oldagg[oldagg$typ=="a" &oldagg$test_num==1, c("sbj_id","rt") ]   
rantiretestoldagg= oldagg[oldagg$typ=="a" &oldagg$test_num==2, c("sbj_id", "rt")] 
rantitrtoldagg <- merge(rantitestoldagg,  rantiretestoldagg, by = c("sbj_id"))
riccantitrtoldagg = icc(type = "agreement", ratings = (rantitrtoldagg[, c(2,3)]))
riccantitrtoldagg

rprotestyoungagg= youngagg[youngagg$typ=="p" &youngagg$test_num==1, c("sbj_id", "rt") ]   
rproretestyoungagg= youngagg[youngagg$typ=="p" &youngagg$test_num==2, c("sbj_id", "rt")] 
rprotrtyoungagg <- merge(rprotestyoungagg,  rproretestyoungagg, by = c("sbj_id"))
riccprotrtyoungagg = icc(type = "agreement", ratings = (rprotrtyoungagg[, c(2,3)]))
riccprotrtyoungagg

rantitestyoungagg= youngagg[youngagg$typ=="a" &youngagg$test_num==1, c("sbj_id", "rt") ]   
rantiretestyoungagg= youngagg[youngagg$typ=="a" & youngagg$test_num==2, c("sbj_id", "rt")] 
rantitrtyoungagg <- merge(rantitestyoungagg,  rantiretestyoungagg, by = c("sbj_id"))
riccantitrtyoungagg = icc(type = "agreement", ratings = (rantitrtyoungagg[, c(2,3)]))
riccantitrtyoungagg

#####GAIN
gprotestoldagg= oldagg[oldagg$typ=="p" &oldagg$test_num==1, c("sbj_id", "gain") ]   
gproretestoldagg= oldagg[oldagg$typ=="p" & oldagg$test_num==2, c("sbj_id", "gain")] 
gprotrtoldagg <- merge(gprotestoldagg,  gproretestoldagg, by = c("sbj_id"))
giccprotrtoldagg = icc(type = "agreement", ratings = (gprotrtoldagg[, c(2,3)]))
giccprotrtoldagg

gantitestoldagg= oldagg[oldagg$typ=="a" &oldagg$test_num==1, c("sbj_id","gain") ]   
gantiretestoldagg= oldagg[oldagg$typ=="a" &oldagg$test_num==2, c("sbj_id", "gain")] 
gantitrtoldagg <- merge(gantitestoldagg,  gantiretestoldagg, by = c("sbj_id"))
giccantitrtoldagg = icc(type = "agreement", ratings = (gantitrtoldagg[, c(2,3)]))
giccantitrtoldagg

gprotestyoungagg= youngagg[youngagg$typ=="p" &youngagg$test_num==1, c("sbj_id", "gain") ]   
gproretestyoungagg= youngagg[youngagg$typ=="p" &youngagg$test_num==2, c("sbj_id", "gain")] 
gprotrtyoungagg <- merge(gprotestyoungagg,  gproretestyoungagg, by = c("sbj_id"))
giccprotrtyoungagg = icc(type = "agreement", ratings = (gprotrtyoungagg[, c(2,3)]))
giccprotrtyoungagg

gantitestyoungagg= youngagg[youngagg$typ=="a" &youngagg$test_num==1, c("sbj_id", "gain") ]   
gantiretestyoungagg= youngagg[youngagg$typ=="a" & youngagg$test_num==2, c("sbj_id", "gain")] 
gantitrtyoungagg <- merge(gantitestyoungagg,  gantiretestyoungagg, by = c("sbj_id"))
giccantitrtyoungagg = icc(type = "agreement", ratings = (gantitrtyoungagg[, c(2,3)]))
giccantitrtyoungagg
 

####peak_velocity

pprotestoldagg= oldagg[oldagg$typ=="p" &oldagg$test_num==1, c("sbj_id", "peak_velocity") ]   
pproretestoldagg= oldagg[oldagg$typ=="p" & oldagg$test_num==2, c("sbj_id", "peak_velocity")] 
pprotrtoldagg <- merge(pprotestoldagg,  pproretestoldagg, by = c("sbj_id"))
piccprotrtoldagg = icc(type = "agreement", ratings = (pprotrtoldagg[, c(2,3)]))
piccprotrtoldagg

pantitestoldagg= oldagg[oldagg$typ=="a" &oldagg$test_num==1, c("sbj_id","peak_velocity") ]   
pantiretestoldagg= oldagg[oldagg$typ=="a" &oldagg$test_num==2, c("sbj_id", "peak_velocity")] 
pantitrtoldagg <- merge(pantitestoldagg,  pantiretestoldagg, by = c("sbj_id"))
piccantitrtoldagg = icc(type = "agreement", ratings = (pantitrtoldagg[, c(2,3)]))
piccantitrtoldagg

pprotestyoungagg= youngagg[youngagg$typ=="p" &youngagg$test_num==1, c("sbj_id", "peak_velocity") ]   
pproretestyoungagg= youngagg[youngagg$typ=="p" &youngagg$test_num==2, c("sbj_id", "peak_velocity")] 
pprotrtyoungagg <- merge(pprotestyoungagg,  pproretestyoungagg, by = c("sbj_id"))
piccprotrtyoungagg = icc(type = "agreement", ratings = (pprotrtyoungagg[, c(2,3)]))
piccprotrtyoungagg

pantitestyoungagg= youngagg[youngagg$typ=="a" &youngagg$test_num==1, c("sbj_id", "peak_velocity") ]   
pantiretestyoungagg= youngagg[youngagg$typ=="a" & youngagg$test_num==2, c("sbj_id", "peak_velocity")] 
pantitrtyoungagg <- merge(pantitestyoungagg,  pantiretestyoungagg, by = c("sbj_id"))
piccantitrtyoungagg = icc(type = "agreement", ratings = (pantitrtyoungagg[, c(2,3)]))
piccantitrtyoungagg








