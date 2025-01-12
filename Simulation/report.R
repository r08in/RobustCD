load("Output/Lres_APAWLS.rda")
load("Output/Lres_APAWLS02.rda")
load("Output/Lres_APAWLS03.rda")
load("Output/Lres_PAWLS.rda")
load("Output/Lres_PAWLS02.rda")
load("Output/Lres_PAWLS03.rda")
load("Output/Lres_APAMLS.rda")
load("Output/Lres_APAMLS02.rda")
load("Output/Lres_APAMLS03.rda")
load("Output/Lres_PAMLS.rda")
load("Output/Lres_PAMLS02.rda")
load("Output/Lres_PAMLS03.rda")
load("Output/Lres_mmnng.rda")
load("Output/Lres_mmnng02.rda")
load("Output/Lres_mmnng03.rda")
load("Output/Lres_LTS.rda")
load("Output/Lres_LTS02.rda")
load("Output/Lres_LTS03.rda")
load("Output/Lres_ROSS.rda")
load("Output/Lres_ROSS02.rda")
load("Output/Lres_ROSS03.rda")
load("Output/Lres_ADL.rda")
load("Output/Lres_ADL02.rda")
load("Output/Lres_ADL03.rda")
load("Output/Lres_IPOD.rda")

load("Output/Hres_ADL.rda")
load("Output/Hres_LTS.rda")
load("Output/Hres_APAWLS.rda")
load("Output/Hres_ADL02.rda")
load("Output/Hres_LTS02.rda")
load("Output/Hres_APAWLS02.rda")
load("Output/Hres_ADL03.rda")
load("Output/Hres_LTS03.rda")
load("Output/Hres_APAWLS03.rda")
load("Output/Hres_PAWLS.rda")
load("Output/Hres_PAWLS02.rda")
load("Output/Hres_PAWLS03.rda")
load("Output/Hres_APAMLS.rda")
load("Output/Hres_APAMLS02.rda")
load("Output/Hres_APAMLS03.rda")
load("Output/Hres_PAMLS.rda")
load("Output/Hres_PAMLS02.rda")
load("Output/Hres_PAMLS03.rda")

load("Output/APAWLS_AIC.rda")
load("Output/APAWLS_BIC.rda")
load("Output/PAWLS_AIC.rda")
load("Output/PAWLS_BIC.rda")
L <- 100
res <- list(Lres_ADL, Lres_mmnng, Lres_ROSS, Lres_PAMLS, Lres_APAMLS, Lres_LTS, Lres_PAWLS, Lres_APAWLS)
res02 <- list(Lres_ADL02, Lres_mmnng02, Lres_ROSS02, Lres_PAMLS02, Lres_APAMLS02,
              Lres_LTS02, Lres_PAWLS02, Lres_APAWLS02)
group0 <- c(rep("ALasso", L), rep("MMNNG", L), rep("SROS", L), rep("SROS-2", L), rep("ASROS-2", L),
           rep("SLTS", L), rep("PAWLS", L), rep("APAWLS", L))
model <- c("A","B", "C","D", "E")
g <- 8
m <- 5
# attach(mtcars)
# par(mfrow = c(2, 3))
for(i in 1:m){
  mse <- NULL
  group <- group0
  for(j in 1:g){
    if(i<=2){
      mse <- c(mse, res[[j]][[i]]$mses)
    } else{
      if(j==1){
        group <- group0[-(1:L)]
      }else{
        mse <- c(mse,res02[[j]][[i-2]]$mses)       
      }
    }
  }
  x11()
  boxplot(mse ~ group, main = paste("Case",model[i],sep=""), outline = FALSE)
}


##### beta MSE#####
treamMSE = function(se, pro = 0.1) {
    num = round(length(se) * pro)
    se[-order(se, decreasing = TRUE)[1:num]]
}
#---example1 begin---#
L = 100
L = 90
se1 = c(treamMSE(outA_50$se), treamMSE(outA_ADL50$se), treamMSE(outA_LTS50$se), treamMSE(outA_MM50$se), 
    treamMSE(outA_ROSS50$se))
se2 = c(treamMSE(outB_50$se), treamMSE(outB_ADL50$se), treamMSE(outB_LTS50$se), treamMSE(outB_MM50$se), 
    treamMSE(outB_ROSS50$se))
se3 = c(treamMSE(outC_50$se), treamMSE(outC_LTS50$se), treamMSE(outC_MM50$se), treamMSE(outC_ROSS50$se))
se4 = c(treamMSE(outD2_50$se), treamMSE(outD2_LTS50$se), treamMSE(outD2_MM50$se), treamMSE(outD2_ROSS50$se))

group = c(rep("PAWLS", L), rep("ADL", L), rep("SparseLTS", L), rep("MMNNG", L), rep("SROS", L))
group2 = c(rep("PAWLS", L), rep("SparseLTS", L), rep("MMNNG", L), rep("SROS", L))
m1 = data.frame(se = se1, group = group)
m2 = data.frame(se = se2, group = group)
m3 = data.frame(se = se3, group = group2)
m4 = data.frame(se = se4, group = group2)
x11()
attach(mtcars)
par(mfrow = c(2, 3))
boxplot(se ~ group, data = m1, main = "model A", outline = FALSE)
# boxplot(se~group,data=m2,main='model B',outline=FALSE)
boxplot(se ~ group, data = m3, main = "model C", outline = FALSE)
boxplot(se ~ group, data = m4, main = "model D", outline = FALSE)

# for high dimension
se1 = c(treamMSE(outA_500$se), treamMSE(outA_ADL500$se), treamMSE(outA_LTS500$se))
se2 = c(treamMSE(outB_500$se), treamMSE(outB_ADL500$se), treamMSE(outB_LTS500$se))
se3 = c(treamMSE(outC_500$se), treamMSE(outC_LTS500$se))
se4 = c(treamMSE(outD2_500$se), treamMSE(outD2_LTS500$se))
group = c(rep("PAWL", L), rep("ADL", L), rep("SparseLTS", L))
group2 = c(rep("PAWL", L), rep("SparseLTS", L))
m1 = data.frame(se = se1, group = group)
m2 = data.frame(se = se2, group = group)
m3 = data.frame(se = se3, group = group2)
m4 = data.frame(se = se4, group = group2)
# x11() attach(mtcars) par(mfrow=c(2,2))
boxplot(se ~ group, data = m1, main = "model A", outline = FALSE)
# boxplot(se~group,data=m2,main='model B',outline=FALSE)
boxplot(se ~ group, data = m3, main = "model C", outline = FALSE)
boxplot(se ~ group, data = m4, main = "model D", outline = FALSE)
#---example1 edn---#

#---example2 begin---#
L = 100
se1 = c(outLA_PWLQ$se, outLA_MM$se, outLA_LTS$se, outLA_ADL$se)
se2 = c(outLB_PWLQ$se, outLB_MM$se, outLB_LTS$se, outLB_ADL$se)
se3 = c(outLC_PWLQ$se, outLC_LTS$se, outLC_ADL$se)

group = c(rep("PWLQ", L), rep("MMNNG", L), rep("SpareLTS", L), rep("ADL", L))
m1 = data.frame(se = se1, group = group)
m2 = data.frame(se = se2, group = group)
group = c(rep("PWLQ", L), rep("Spare LTS", L), rep("ADL", L))
m3 = data.frame(se = se3, group = group)
attach(mtcars)
par(mfrow = c(2, 2))
boxplot(se ~ group, data = m1, main = "model LA")
boxplot(se ~ group, data = m2, main = "model LB")
boxplot(se ~ group, data = m3, main = "model LC")
# boxplot(se~group,data=m4,main='model D',ylim=c(0,8))
#---example2 end---#
##### beta MSE end#####

##### w #####
#---example1 begin---#
w1 = OutlierSummary(outA_50$w, pro = 0)
w2 = OutlierSummary(outB_50$w, pro = 0)
w3 = OutlierSummary(outC_50$w)
w4 = OutlierSummary(outD2_50$w)
w4_2 = OutlierSummary(outD2_50_2$w)
# LTS
wLTS1 = OutlierSummary(outA_LTS50$w, pro = 0)
wLTS2 = OutlierSummary(outB_LTS50$w, pro = 0)
wLTS3 = OutlierSummary(outC_LTS50$w)
wLTS4 = OutlierSummary(outD2_LTS50$w)

wH1 = OutlierSummary(outA_500$w, pro = 0)
wH2 = OutlierSummary(outB_500$w, pro = 0)
wH3 = OutlierSummary(outC_500$w)
wH4 = OutlierSummary(outD2_500$w)

wHLTS1 = OutlierSummary(outA_LTS500$w, pro = 0)
wHLTS2 = OutlierSummary(outB_LTS500$w, pro = 0)
wHLTS3 = OutlierSummary(outC_LTS500$w)
wHLTS4 = OutlierSummary(outD2_LTS500$w)
#---example1 end---#

#---example2 begin---#
wLA_PWLQ = OutlierSummary(outLA_PWLQ$w)
wLB_PWLQ = OutlierSummary(outLB_PWLQ$w)
wLC_PWLQ = OutlierSummary(outLC_PWLQ$w)

#---example2 end---#

## plot air pollution ##
x11()
par(mfrow = c(1, 3))
# 1
index = 1:59
plot(studres, type = "n", xlab = "Observations", ylab = "Studentized Residuals")
points(index[res_air$w == 1], studres[res_air$w == 1], type = "p", pch = 20)
points(index[res_air$w != 1], studres[res_air$w != 1], type = "p", pch = 17, col = "red3")
abline(2.5, 0, lty = 2, col = "gray60")
abline(-2.5, 0, lty = 2, col = "gray60")
# 2
paramPlot(res_air, xlimw = c(1, 12))


## plot NCI
x11()
par(mfrow = c(1, 3))
index = 1:59
plot(studres_nci, type = "n", xlab = "Observations", ylab = "Studentized Residuals")
points(index[res_nci$w == 1], studres_nci[res_nci$w == 1], type = "p", pch = 20)
points(index[res_nci$w != 1], studres_nci[res_nci$w != 1], type = "p", pch = 17, col = "red3")
abline(2.5, 0, lty = 2, col = "gray60")
abline(-2.5, 0, lty = 2, col = "gray60")
paramPlot(res_nci, param = "both", ylimw = c(0, 12), xlimw = c(7.5, 13))
