library(doParallel)
library(foreach)
source("Simulation/Simulation.R")
# n=50,p=8----------------------------------------------
L = 100
n = 50
p = 8
beta = c(3, 2, 1.5, 0, 0, 0, 0, 0)
#beta = c(0, 0, 0, 0, 0, 0, 0, 0)


# MMNNG(yes)
pro=0.1
# Lres_mmnngA = simulation(L, n, beta, "A", method = "MMNNG_DATA", useDataFile = T, seed = NULL, pro=pro)
# Lres_mmnngB = simulation(L, n, beta, "B", method = "MMNNG_DATA", useDataFile = T, seed = NULL, pro=pro)
# Lres_mmnngC = simulation(L, n, beta, "C", method = "MMNNG_DATA", useDataFile = T, seed = NULL, pro=pro)
# Lres_mmnngD = simulation(L, n, beta, "D", method = "MMNNG_DATA", useDataFile = T, seed = NULL, pro=pro)
# 
# Lres_mmnngE1 = simulation(L, n, beta, "E", method = "MMNNG_DATA", useDataFile = T, seed = NULL, pro=0.1)
# Lres_mmnngE2 = simulation(L, n, beta, "E", method = "MMNNG_DATA", useDataFile = T, seed = NULL, pro=0.2)
# Lres_mmnngE3 = simulation(L, n, beta, "E", method = "MMNNG_DATA", useDataFile = T, seed = NULL, pro=0.3)
# Lres_mmnng = simulation(L, n, beta, c("A", "B", "C", "D","E"), method = "MMNNG_DATA", useDataFile = TRUE, seed = NULL)
# Lres_mmnng02 = simulation(L, n, beta, c("C", "D","E"), method = "MMNNG_DATA", useDataFile = TRUE, seed = NULL,pro=0.2)
# Lres_mmnng03 = simulation(L, n, beta, c("C", "D","E"), method = "MMNNG_DATA", useDataFile = TRUE, seed = NULL,pro=0.3)
# save(Lres_mmnng, file = "Output/Lres_mmnng.rda")
# save(Lres_mmnng02, file = "Output/Lres_mmnng02.rda")
# save(Lres_mmnng03, file = "Output/Lres_mmnng03.rda")

# PAMLS

Lres_PAMLS  <- simulation(L, n, beta, c("A", "B", "C", "D","E"), method = "PAMLS", initial = "uniform", 
                          seed = NULL, useDataFile = TRUE,       
                          updateInitial =FALSE, intercept = TRUE, criterion = "BIC", search = "all")

Lres_PAMLS02  <- simulation(L, n, beta, c( "C", "D","E"), method = "PAMLS", initial = "uniform", 
                            lambda2.min=1e-03, lambda1.min=0.05,
                            seed = NULL, useDataFile = TRUE,       
                            updateInitial =FALSE, intercept = TRUE, criterion = "BIC",pro=0.2, search = "all")

Lres_PAMLS03  <- simulation(L, n, beta, c( "C", "D","E"), method = "PAMLS", initial = "uniform", 
                            lambda2.min=1e-03, lambda1.min=0.05,
                            seed = NULL, useDataFile = TRUE,       
                            updateInitial =FALSE, intercept = TRUE, criterion = "BIC",pro=0.3, search = "all")
save(Lres_PAMLS, file = "Output/Lres_PAMLS.rda")
save(Lres_PAMLS02, file = "Output/Lres_PAMLS02.rda")
save(Lres_PAMLS03, file = "Output/Lres_PAMLS03.rda")
load("Output/Lres_PAMLS.rda")
load("Output/Lres_PAMLS02.rda")
load("Output/Lres_PAMLS03.rda")


# APAMLS
Lres_APAMLS  <- simulation(L, n, beta, c("A", "B", "C", "D","E"), method = "PAMLS", initial = "PAMLS", 
                          #lambda2.min=0.05, lambda1.min=0.01,
                          lambda2.min=0.05, lambda1.min=0.001,
                          seed = NULL, useDataFile = TRUE,       
                          updateInitial =FALSE, intercept = TRUE, criterion = "BIC")

Lres_APAMLS02  <- simulation(L, n, beta, c( "C", "D","E"), method = "PAMLS", initial = "PAMLS", 
                             lambda2.min=0.05, lambda1.min=0.001,
                            seed = NULL, useDataFile = TRUE,       
                            updateInitial =FALSE, intercept = TRUE, criterion = "BIC",pro=0.2)

Lres_APAMLS03  <- simulation(L, n, beta, c( "C", "D","E"), method = "PAMLS", initial = "PAMLS", 
                             lambda2.min=0.05, lambda1.min=0.001,
                            seed = NULL, useDataFile = TRUE,       
                            updateInitial =FALSE, intercept = TRUE, criterion = "BIC",pro=0.3)
save(Lres_APAMLS, file = "Output/Lres_APAMLS.rda")
save(Lres_APAMLS02, file = "Output/Lres_APAMLS02.rda")
save(Lres_APAMLS03, file = "Output/Lres_APAMLS03.rda")
load("Output/Lres_APAMLS.rda")
load("Output/Lres_APAMLS02.rda")
load("Output/Lres_APAMLS03.rda")
Hres_APAMLS <- Lres_APAMLS
Hres_APAMLS02 <- Lres_APAMLS02
Hres_APAMLS03 <- Lres_APAMLS03
Hres_PAMLS <- Lres_PAMLS
Hres_PAMLS02 <- Lres_PAMLS02
Hres_PAMLS03 <- Lres_PAMLS03

# LTS(yes)
require(robustHD)
Lres_LTS = simulation(L, n, beta, c("A", "B", "C", "D","E"), method = "LTS", useDataFile = TRUE)
Lres_LTS02 = simulation(L, n, beta, c("C", "D","E"), method = "LTS", useDataFile = TRUE, pro=0.2)
Lres_LTS03 = simulation(L, n, beta, c("C", "D","E"), method = "LTS", useDataFile = TRUE, pro=0.3)

save(Lres_LTS, file = "Output/Lres_LTS.rda")
save(Lres_LTS02, file = "Output/Lres_LTS02.rda")
save(Lres_LTS03, file = "Output/Lres_LTS03.rda")
fpr <- Lres_LTS[[3]]$OD$fpr
tpr <- Lres_LTS[[3]]$OD$tpr
plot(fpr,tpr,type="p")


# APAWLS

Lres_APAWLS  <- simulation(L, n, p=p,beta, c( "A", "B", "C", "D", "E"), method = "PAWLS", initial = "PAWLS", 
                         seed = NULL, useDataFile = T,       
                         updateInitial =FALSE, intercept = TRUE)


Lres_APAWLS02  <- simulation(L, n, beta, c( "C", "D","E"), method = "PAWLS", initial = "PAWLS", 
                           lambda2.min=0.05, lambda1.min=0.001,
                           seed = NULL, useDataFile = TRUE,       
                           updateInitial =FALSE, intercept = TRUE, criterion = "BIC",pro=0.2)

Lres_APAWLS03  <- simulation(L, n, beta, c( "C", "D","E"), method = "PAWLS", initial = "PAWLS", 
                           lambda2.min=0.05, lambda1.min=0.001,
                           seed = NULL, useDataFile = TRUE,       
                           updateInitial =FALSE, intercept = TRUE, criterion = "BIC",pro=0.3)

# endreq(Hres_APAWLS,100,5,t=2)
# endreq(Hres_APAWLS,50,5,t=1)
save(Lres_APAWLS, file = "Output/Lres_APAWLS.rda")
save(Lres_APAWLS02, file = "Output/Lres_APAWLS02.rda")
save(Lres_APAWLS03, file = "Output/Lres_APAWLS03.rda")
load("Output/Lres_APAWLS.rda")


fpr3 <- Lres_APAWLS[[3]]$OD$fpr
tpr3 <- Lres_APAWLS[[3]]$OD$tpr
fpr4 <- Lres_APAWLS[[4]]$OD$fpr
tpr4 <- Lres_APAWLS[[4]]$OD$tpr
fpr5 <- Lres_APAWLS[[5]]$OD$fpr
tpr5 <- Lres_APAWLS[[5]]$OD$tpr
plot(fpr3,tpr3,type="l", main="ROC Curve", xlab="Sensitivity", ylab="Specificity",lwd=2, lty=1, col="green")
lines(fpr4,tpr4,lwd=2, lty=1,col="blue")
lines(fpr5,tpr5,lwd=2, lty=1,col="red")
legend(0.6,0.6,legend=c("Case C", "Case D", "Case E"), col=c("green","blue","red"), lwd=3)



# PAWLS

Lres_PAWLS  <- simulation(L, n, p=p, beta, c("A", "B","C", "D","E"), method = "PAWLS", initial = "uniform",
                           seed = 2021, useDataFile = T,       
                           updateInitial =FALSE, intercept = TRUE, criterion = "BIC", search = "grid")

Lres_PAWLS02  <- simulation(L, n, beta, c( "C", "D","E"), method = "PAWLS", initial = "uniform", 
                            lambda2.min=1e-03, lambda1.min=0.05,
                             seed = NULL, useDataFile = TRUE,       
                             updateInitial =FALSE, intercept = TRUE, criterion = "BIC",pro=0.2, search = "all")

Lres_PAWLS03  <- simulation(L, n, beta, c( "C", "D","E"), method = "PAWLS", initial = "uniform", 
                            lambda2.min=1e-03, lambda1.min=0.05,
                             seed = NULL, useDataFile = TRUE,       
                             updateInitial =FALSE, intercept = TRUE, criterion = "BIC",pro=0.3, search = "all")

endreq(Hres_APAWLS,100,5,t=2)
endreq(Hres_APAWLS,50,5,t=1)
save(Lres_PAWLS, file = "Output/Lres_PAWLS.rda")
save(Lres_PAWLS02, file = "Output/Lres_PAWLS02.rda")
save(Lres_PAWLS03, file = "Output/Lres_PAWLS03.rda")
load("Output/Lres_PAWLS.rda")

# ROSS(yes)
matLabDir = paste(getwd(),"Simulation/ROSS" , sep = "/")
source("Simulation/SetupMatlab.R")
matlab = PrepareMatlab(matLabDir)
Lres_ROSS <- simulation(L, n, beta, c("A", "B", "C", "D","E"), method = "ROSS",matlab = matlab,
                        seed = NULL, useDataFile = TRUE, intercept = TRUE)
Lres_ROSS02 <- simulation(L, n, beta, c("C", "D","E"), method = "ROSS",matlab = matlab,
                        seed = NULL, useDataFile = TRUE, intercept = TRUE, pro=0.2)
Lres_ROSS03 <- simulation(L, n, beta, c("C", "D","E"), method = "ROSS",matlab = matlab,
                          seed = NULL, useDataFile = TRUE, intercept = TRUE, pro=0.3)
save(Lres_ROSS , file = "Output/Lres_ROSS.rda")
save(Lres_ROSS02 , file = "Output/Lres_ROSS02.rda")
save(Lres_ROSS03 , file = "Output/Lres_ROSS03.rda")
# ADL
require(ncvreg)
Lres_ADL = simulation(L, n, beta, c("A", "B", "C", "D","E"), method = "ADL", useDataFile = TRUE)
Lres_ADL02 = simulation(L, n, beta, c("C", "D","E"), method = "ADL", useDataFile = TRUE,pro=0.2)
Lres_ADL03 = simulation(L, n, beta, c("C", "D","E"), method = "ADL", useDataFile = TRUE,pro=0.3)
save(Lres_ADL , file = "Output/Lres_ADL.rda")
save(Lres_ADL02 , file = "Output/Lres_ADL02.rda")
save(Lres_ADL03 , file = "Output/Lres_ADL03.rda")
require(ncvreg)
test_Lasso = simulation(L, n, beta, c("A"), method = "Lasso", useDataFile = T, seed=2016)
test_Lasso = simulation(L, n, beta, c("A"), method = "Lasso", useDataFile = T, seed=2016)
# IPOD
Lres_IPOD <- simulation(L, n, beta, c("A","B","C","D","E"),  method = "IPOD", useDataFile = TRUE)
save(Lres_IPOD  , file = "Output/Lres_IPOD.rda")
fpr <- Lres_IPOD [[3]]$OD$fpr
tpr <- Lres_IPOD [[3]]$OD$tpr
plot(fpr,tpr,type="p")
#-------------------------------------------------------------------------------------
source("Simulation/Simulation.R")
# n=100,500
L = 100
n = 100
p = 500
num = 10
beta = c(rep(2, num), rep(0, p - num))

# LTS
require(robustHD)
Hres_LTS = simulation(L, n, beta, c("A", "B", "C", "D","E"), method = "LTS", useDataFile = T, seed=2016)
Hres_LTS02 = simulation(L, n, beta, c("C", "D"), method = "LTS", useDataFile = T, seed=2016, pro=0.2)
Hres_LTS03 = simulation(L, n, beta, c("C", "D"), method = "LTS", useDataFile = T, seed=2016, pro=0.3)
save(Hres_LTS, file = "Output/Hres_LTS.rda")
save(Hres_LTS02, file = "Output/Hres_LTS02.rda")
save(Hres_LTS03, file = "Output/Hres_LTS03.rda")
Hres_LTSE = simulation(L, n, beta, c("E"), method = "LTS", useDataFile = T, seed=2016)
Hres_LTSE02 = simulation(L, n, beta, c("E"), method = "LTS", useDataFile = T, seed=2016, pro=0.2)
Hres_LTSE03 = simulation(L, n, beta, c("E"), method = "LTS", useDataFile = T, seed=2016, pro=0.3)

load("Output/Hres_LTS.rda")

#APAWLS
Hres_APAMLS <- simulation(L, n, beta, c("A", "B", "C", "D","E"), method = "PAMLS", initial = "PAMLS",
                          seed = 2016, useDataFile = T, updateInitial = FALSE, 
                          intercept = TRUE )


Hres_APAMLS02 <- simulation(L, n, beta, c("C", "D","E"), method = "PAMLS", initial = "PAMLS",
                            lambda2.min=1e-3, lambda1.min=0.05,
                            seed = 2016, useDataFile = T, updateInitial = FALSE, intercept = TRUE,pro=0.2 )
Hres_APAMLS03 <- simulation(L, n, beta, c("C", "D","E"), method = "PAMLS", initial = "PAMLS",
                            lambda2.min=1e-3, lambda1.min=0.05,
                            seed = 2016, useDataFile = T, updateInitial = FALSE, intercept = TRUE,pro=0.3 )
save(Hres_APAMLS, file = "Output/Hres_APAMLS.rda")
save(Hres_APAMLS02, file = "Output/Hres_APAMLS02.rda")
save(Hres_APAMLS03, file = "Output/Hres_APAMLS03.rda")

#PAMLS
Hres_PAMLS <- simulation(L, n, beta, c("A", "B", "C", "D","E"), method = "PAMLS", initial = "uniform",
                         seed = 2016, useDataFile = T, updateInitial = FALSE, 
                         intercept = TRUE, search = "all")


Hres_PAMLS02 <- simulation(L, n, beta, c("C", "D","E"), method = "PAMLS", initial = "uniform",
                           lambda2.min=1e-3, lambda1.min=0.05,
                           seed = 2016, useDataFile = T, updateInitial = FALSE,
                           intercept = TRUE,pro=0.2, search = "all")
Hres_PAMLS03 <- simulation(L, n, beta, c("C", "D","E"), method = "PAMLS", initial = "uniform",
                           lambda2.min=1e-3, lambda1.min=0.05,
                           seed = 2016, useDataFile = T, updateInitial = FALSE,
                           intercept = TRUE,pro=0.3, search = "all")

save(Hres_PAMLS, file = "Output/Hres_PAMLS.rda")
save(Hres_PAMLS02, file = "Output/Hres_PAMLS02.rda")
save(Hres_PAMLS03, file = "Output/Hres_PAMLS03.rda")


#APAWLS
Hres_APAWLS <- simulation(L, n, beta, c("A", "B", "C", "D","E"), method = "PAWLS", initial = "PAWLS",
                          seed = 2016, useDataFile = T, updateInitial = FALSE, 
                          intercept = TRUE )


Hres_APAWLS02 <- simulation(L, n, beta, c("C", "D","E"), method = "PAWLS", initial = "PAWLS",
                            lambda2.min=1e-3, lambda1.min=0.05,
                          seed = 2016, useDataFile = T, updateInitial = FALSE, intercept = TRUE,pro=0.2 )
Hres_APAWLS03 <- simulation(L, n, beta, c("C", "D","E"), method = "PAWLS", initial = "PAWLS",
                            lambda2.min=1e-3, lambda1.min=0.05,
                          seed = 2016, useDataFile = T, updateInitial = FALSE, intercept = TRUE,pro=0.3 )
save(Hres_APAWLS, file = "Output/Hres_APAWLS.rda")
save(Hres_APAWLS02, file = "Output/Hres_APAWLS02.rda")
save(Hres_APAWLS03, file = "Output/Hres_APAWLS03.rda")
load("Output/Hres_APAWLS.rda")
load("Output/Hres_APAWLS02.rda")
load("Output/Hres_APAWLS03.rda")
Hres_APAWLS0 <- Hres_APAWLS
Hres_APAWLS <- test_APAWLS

# PAWLS
Hres_PAWLS <- simulation(L, n, beta, c("A", "B", "C", "D","E"), method = "PAWLS", initial = "uniform",
                          seed = 2016, useDataFile = F, updateInitial = FALSE, 
                          intercept = TRUE, search = "all")


Hres_PAWLS02 <- simulation(L, n, beta, c("C", "D","E"), method = "PAWLS", initial = "uniform",
                            lambda2.min=1e-3, lambda1.min=0.05,
                            seed = 2016, useDataFile = T, updateInitial = FALSE,
                           intercept = TRUE,pro=0.2, search = "all")
Hres_PAWLS03 <- simulation(L, n, beta, c("C", "D","E"), method = "PAWLS", initial = "uniform",
                            lambda2.min=1e-3, lambda1.min=0.05,
                            seed = 2016, useDataFile = T, updateInitial = FALSE,
                           intercept = TRUE,pro=0.3, search = "all")

save(Hres_PAWLS, file = "Output/Hres_PAWLS.rda")
save(Hres_PAWLS02, file = "Output/Hres_PAWLS02.rda")
save(Hres_PAWLS03, file = "Output/Hres_PAWLS03.rda")

# ADL
require(ncvreg)
Hres_ADL = simulation(L, n, beta, c("A", "B", "C", "D","E"), method = "ADL", useDataFile = T, seed=2016)
Hres_ADL02 = simulation(L, n, beta, c("C", "D","E"), method = "ADL", useDataFile = T, seed=2016,pro=0.2)
Hres_ADL03 = simulation(L, n, beta, c("C", "D","E"), method = "ADL", useDataFile = T, seed=2016,pro=0.3)
test_ADL = simulation(L, n, beta, c("A"), method = "ADL", useDataFile = T, seed=2016)
save(Hres_ADL , file = "Output/Hres_ADL.rda")
save(Hres_ADL02 , file = "Output/Hres_ADL02.rda")
save(Hres_ADL03, file = "Output/Hres_ADL03.rda")
load("Output/Hres_ADL.rda")



# ======real data analysis(air pollution)============# airRaw=read.delim('airPollution.txt')
airData = airRaw[-21, -1]
airData$HCPot = log(airData$HCPot)
airData$NOxPot = log(airData$NOxPot)
airData$S02Pot = log(airData$S02Pot)
# tempData=t(airData)-apply(airData,2,median) data=t(tempData/apply(abs(tempData),1,median))
# y=data[,5] x=data[,-c(5,16)] out=list(y=y,x=x)
y = airData[, 5]
x = airData[, -c(5, 16)]
out = DataNormByMAD(x, y)
colnames = names(airData[, -c(5, 16)])
colnames[7] = "NonWhite"
# OLS
lm1 = lm(y ~ x)
lm0 = lm(as.vector(airData[, 5]) ~ as.matrix(airData[, -c(5)]))

# Apwls
res_air0 = pawls(out$x, out$y)
res_air = pawls(out$x, out$y, initial = "PAWLS", search = "cross", criterion = "BIC", updateInitialTimes = 2)
res_air = pawls(out$x, out$y, initial = "PAWLS", search = "crossDynamic", criterion = "BIC", updateInitialTimes = 2)

res2_air = res_air
res2_air = pawls(out$x, out$y, initial = "LTS", search = "all")
colnames[res_air$beta[-1] != 0]
studres = studres(lm1)
plot(studres)
abline(2.5, 0)
identify(studres)
paramPlot(res2_air, xlimw = c(6, 12))
# getlabel
label_beta = rep(colnames, 100)
paramPlot(res2_air, label2 = label_beta)

# ADL
res_air_ADL = pawls(out$x, out$y, nlambda2 = 1, initial = "LASSO", search = "fixw")
colnames[res_air_ADL$beta[-1] != 0]

# sLTS
require(robustHD)
res_air_LTS = sparseLTS(out$x, out$y, intercept = TRUE)
colnames[res_air_LTS$coefficients[-1] != 0]

# MMNNG
source("mmnngreg.R")
res_air_MMNNG = mmnngreg(out$x, out$y)
colnames[res_air_MMNNG$betac[-1] != 0]

# SROS
x = AddIntercept(out$x)
setVariable(matlab, X = x)
setVariable(matlab, y = out$y)
evaluate(matlab, "[betaRoss]=Rosssimulation(X,y)")
res_air_Ross = getVariable(matlab, "betaRoss")
colnames[res_air_Ross$betaRoss[-1] != 0]

# ======real data analysis(NCI-60)============# read data
# nci_pro=read.delim('nci60_Protein__Lysate_Array_log2.txt')
# nci_gene0=read.delim('RNA__Affy_HG_U133(A_B)_GCRMA.txt') nci_temp=read.delim('GPL96-15653.txt')
nci_gene = nci_gene0[nci_gene0$Probe.id..b. %in% nci_temp$ID, ]
cnames = nci_gene[, 2]
# obtain X and y

x = t(nci_gene[, -c(1:9, 49, 70)])
x = matrix(as.numeric(x), nrow = dim(x)[1])
colnames(x) <- cnames
y = as.numeric(nci_pro[92, -c(1:4, 44, 65)])
screenNum = 500
out = ScreenData(y, x, screenNum)
out = DataNormByMAD(out$x, out$y)
colname = colnames(out$x)

# ADL
res_nci_ADL = pawls(out$x, out$y, nlambda2 = 1, initial = "LASSO", search = "fixw")
lm_nci = lm(out$y ~ out$x[, res_nci_ADL$beta[-1] != 0])
studres_nci = studres(lm_nci)
studres_nci = out$y - out$x %*% res_nci_ADL$beta[-1] - res_nci_ADL$beta[1]
colnames[res_nci_ADL$beta[-1] != 0]

# LTS
require(robustHD)
# class(out$x)<-'numeric'
res = sparseLTS(out$x, out$y)
res$coefficients[res$coefficients != 0]


# ols
lm_nci = lm(out$y ~ out$x)
studres_nci = studres(lm_nci)
# pwls-vs lambda1=c(0.4304376,0.2141318,0)
res_nci_0 = pawls(out$x, out$y,standardize = TRUE, initial = "uniform", intercept = TRUE, search="all")
res_nci = pawls(out$x, out$y, initial = "PAWLS",lambda2.min=1e-3, lambda1.min=0.001)
res_nci_PAWLS = pawls(out$x, out$y, initial = "uniform", search = "all", criterion = "BIC", updateInitialTimes = 0)
res_nci = pawls(out$x, out$y, initial = "PAWLS", search = "crossDynamic", criterion = "BIC", updateInitialTimes = 2, 
    standardize = TRUE)
names(res_nci$beta) <- c("intercept", colname)
res_nci$beta[res_nci$beta != 0]


# seq(0.02013544,0,length.out=100)
corr = cor(out$x[, 1], out$x[, -1])
View(corr[order(abs(corr), decreasing = TRUE)])

res_nci2 = pawls(out$x[, -1], out$y - (out$x[, 1] * res_nci$beta[2]), updateInitialTimes = 4)  #1

i = index[res2_nci$beta[-1] != 0]
res2_nci$beta[res2_nci$beta != 0]
colname[i]
# ======end of data analysis===========#

# =======temp==========#
View(outD2_50$beta)
View(outD2_LTS50$beta)
se = c(outD2_50$se, outD2_LTS50$se)
group = c(rep("PAWLS", 100), rep("SparseLTS", 100))
m = data.frame(se = se, group = group)
boxplot(se ~ group, data = m, main = "model D", outline = FALSE)


# =======end temp=======#
