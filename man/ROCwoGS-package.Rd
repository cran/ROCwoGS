\name{ROCwoGS-package}
\alias{ROCwoGS-package}
\alias{ROCwoGS}
\docType{package}
\title{
Non-parametric estimation of ROC curves without Gold Standard
}
\description{
Function to estimate the ROC Curve of a continuous-scaled diagnostic test with the help of a second imperfect diagnostic test with binary responses.
}
\details{
\tabular{ll}{
Package: \tab ROCwoGS\cr
Type: \tab Package\cr
Version: \tab 1.0\cr
Date: \tab 2010-09-13\cr
License: \tab GPL (>= 2)\cr
LazyLoad: \tab no \cr
}
This package contains one function.NPROCwoGS estimates the ROC Curve of a continuous-scaled diagnostic test with the help of a second imperfect diagnostic test with binary responses

}
\author{
Chong Wang <\email{chwang@iastate.edu}>

Maintainer: Chong Wang <\email{chwang@iastate.edu}>
}
\references{
Wang, C., Turnbull, B. W., Grohn, Y. T. and Nielsen, S. S. (2007). Nonparametric Estimation of ROC Curves Based on Bayesian Models When the True Disease State Is Unknown. Journal of Agricultural, Biological and Environmental Statistics 12, 128-146. 
}

\keyword{ package }

\examples{
data(score)
score$r <- (score$r >= 3)
ncutoff<- 20
ROC.est<-NPROCwoGS (score, ncutoff, niter=2000, CIlevel=0.95)
#Print results on R screen
ROC.est
#Calculate area under the curve
AUC<- sum((ROC.est$T.Se[1,-1]+ROC.est$T.Se[1,-(ncutoff+2)])*(ROC.est$T.Sp[1,-1]-ROC.est$T.Sp[1,-(ncutoff+2)])/2)
#Find the optimal cutoff to maximize
#Youden Index
opt.cut<- ROC.est$cutoff[which.max(ROC.est$T.Se[1,]+ROC.est$T.Sp[1,])-1]
# Plot ROC curve
plot(1-ROC.est$T.Sp[1,],ROC.est$T.Se[1,],"l", xlab="1-Specificities",ylab="Sensitivities", main=paste("AUC=", format(AUC, digits=4),
        ", Optimal Cutoff=",opt.cut))        
data.frame(1-ROC.est$T.Sp)[c(3,2),]->ci.tsp
data.frame(ROC.est$T.Se)[c(2,3),]->ci.tse
#Write Sensitivities and Specificities to 
#".csv" files, saved in the R library path
#write.csv(ROC.est$T.Se,
#paste(.Library,"/ROCwoGS/data/T_Se.csv",sep=''))
#write.csv(ROC.est$T.Sp,
#paste(.Library,"/ROCwoGS/data/T_Sp.csv",sep=''))
}
