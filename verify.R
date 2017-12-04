# R script to verify the air2water simulation for the Hancza lake:

# reading the calibration and validation results:
column_names <-  c("yy","mm","dd","temp_p_obs", "temp_j_obs","temp_j_air2water",  "temp_p_aggr", "temp_j_aggr")
air2water_cal <- na.omit(read.table("Hancza/output_2/2_PSO_RMS_hancza_sat_cc_1d.out", na.strings = "-999.00000", col.names = column_names))
air2water_val  <- na.omit(read.table("Hancza/output_2/3_PSO_RMS_hancza_sat_cv_1d.out", na.strings = "-999.00000", col.names = column_names))


head(air2water_cal)

library(dplyr)
summary_mth_cal <- air2water_cal %>% group_by(yy,mm) %>% summarise_all(., mean) 
summary_mth_val <- air2water_val %>% group_by(yy,mm) %>% summarise_all(., mean) 


library(verification)
png("hancza_calibration.png", height = 800, width = 800, pointsize = 20)
plot(verify(obs = summary_mth_cal$temp_j_obs, pred = summary_mth_cal$temp_j_air2water, frcst.type = "cont",
            obs.type = "cont"),  main="Conditional Quantile Plot - calibration period\nHancza Lake")
dev.off()

png("hancza_validation.png", height = 800, width = 800, pointsize = 20)
plot(verify(obs = summary_mth_val$temp_j_obs, pred = summary_mth_val$temp_j_air2water, frcst.type = "cont",
             obs.type = "cont"), main="Conditional Quantile Plot - validation period\nHancza Lake")
dev.off()


library(hydroGOF)
verify(obs = summary_mth_val$temp_j_obs, pred = summary_mth_val$temp_j_air2water, frcst.type = "cont",obs.type = "cont")[1:5]
verify(obs = summary_mth_cal$temp_j_obs, pred = summary_mth_cal$temp_j_air2water, frcst.type = "cont",obs.type = "cont")[1:5]
library(plotrix)
taylor.diagram(ref = summary_mth_val$temp_j_obs, model =  summary_mth_val$temp_j_air2water)
taylor.diagram(ref = summary_mth_cal$temp_j_obs, model =  summary_mth_cal$temp_j_air2water, add=T)
cor(summary_mth_val$temp_j_obs, summary_mth_val$temp_j_air2water)
######################################################
# everything below is not important for this case... #
######################################################
#a <- verify(obs = podsumowanie$temp_j_obs, pred = podsumowanie$temp_j_air2water, frcst.type = "cont",obs.type = "cont")
# wynik_model_rec <- readRDS(file="data/wynik_model_rec_hist.rds")
# charzykowskie <- wynik_model_rec %>% filter(nazwa=="Charzykowskie") 
# head(charzykowskie)
# head(podsumowanie)
# charzykowskie <- left_join(charzykowskie, podsumowanie)
# charzykowskie <- charzykowskie %>% filter(yy>=2000)