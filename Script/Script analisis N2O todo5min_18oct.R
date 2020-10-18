print ("This file was created within RStudio")
print("And now it lives on GitHub")

#Datos para determinar el Minimal Detectable Flux - f. detect - app Dr. Hüppi
#para cinco minutos todos los riegos 
# tiempo: 0; 0.006; 0.012; 0.018; 0.024; 0.030; 0.036; 0.042; 0.048; 0.054; 0.061; 0.067; 0.073; 0.079; 0.085; 0.091
# cámara: área cámara (m2): 0.169646
# volumen cámara (m3): 0.05340072
#  desv. estándar N2O: 11 (ppb)
# opción: No lineal
# resultado app: 
# [1] "Estimated minimal detectable flux:"
# 97.5% 
# 0.4246538
# [1] "[mg N2O/m^2/h ]"
# [1] "Number of HMR fluxes detected:"
# [1] 25

library("gasfluxes")
fluxMeas_N2O_todo5min <- read_excel("Data/BaseR_N2O/BaseR_N2O_5min_todosriego2.xlsx")
gasfluxes(fluxMeas_N2O_todo5min, .id = "serie", .V = "V", .A = "A", .times = "time",.C = "C", methods = c("linear", "robust linear", "HMR", "NDFE"),k_HMR = log(1.5), k_NDFE = log(0.01),verbose = FALSE, plot = FALSE)
f.detect <- 0.4246538

t.meas3 <- max(fluxMeas_N2O_todo5min$time)
# resultado t.meas: 0.090833333262708; es igual a t.meas del primer analisis

resN2O_5t <- gasfluxes(fluxMeas_N2O_todo5min,.id = "serie", .V = "V", .A = "A",.times = "time", .C = "C",methods = c("linear", "robust linear", "HMR"), verbose = FALSE, plot = FALSE)
selectfluxes(resN2O_5t, "kappa.max", f.detect = f.detect, t.meas = t.meas)
write.table(resN2O_5t, file="Res_N2O_5mintodo_18oct.csv", row.names = FALSE, sep = " , ")
