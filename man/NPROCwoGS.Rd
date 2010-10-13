\name{NPROCwoGS}
\alias{NPROCwoGS}

\title{
Non-parametric estimation of ROC curves without Gold Standard
}

\description{
Function to estimate the ROC Curve of a continuous-scaled diagnostic test with the help of a second imperfect diagnostic test with binary responses.
}
\usage{
NPROCwoGS(score, ncutoff, niter, CIlevel)
}

%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{score}{A data frame with the first column of the continuous-scaled diagnostic test scores; the second column of the binary reference scores; the third column of a factor vector to indicate the population that the observations come from. 
}
 \item{ncutoff}{
Desired number of cutoff values. This determines the number of estimated pairs of (sensitivity, specificity) along the ROC curve.
}
  \item{niter}{
Desired number of iterations for the Markov Chain Monte Carlo method. 
}
  \item{CIlevel}{
Desired level of credible intervals. A numeric value between 0 and 1.
}
}
\details{
The method is based on a multinomial model for the joint distribution of test-positive and test-negative observations. The estimated ROC curve of the continuous-scaled test is in the form of pairs of sensitivities and specificities. Also estimated are the sensitivity and specificity of the binary reference test and the population disease prevelances. 
}
\value{
NPROCwoGS produces an ordinary list with the following components. 
\item{cutoff}{Cutoff values for the continuous-scaled diagnostic test. The length of cutoff is the same as the input ncutoff}
\item{T.Se}{Point estimates (first row) and credible intervals (second and third rows) of the sensitivities for the continuous-scaled diagnostic test}
\item{T.Sp}{Point estimates (first row) and credible intervals (second and third rows) of the specificities for the continuous-scaled diagnostic test}
\item{R.Se}{Point estimate and the lower bound and upper bound of the credible interval of the sensitivity for the binary reference test}
\item{R.Sp}{Point estimate and the lower bound and upper bound of the credible interval of the specificity for the binary reference test}
\item{Prev}{Point estimates (first row) and credible intervals (second and third rows) of the population disease prevelances. Each column represents a population}
\item{flag}{	Flag for potential nonidentifiable configurations. flag=0: no flag is raised, flag=1: Flag 1 is raised; flag=2: Flag 2 is raised; flag=3: both flags are raised}
}
\references{
Wang, C., Turnbull, B. W., Grohn, Y. T. and Nielsen, S. S. (2007). Nonparametric Estimation of ROC Curves Based on Bayesian Models When the True Disease State Is Unknown. Journal of Agricultural, Biological and Environmental Statistics 12, 128-146. 
}
\author{
Chong Wang <\email{chwang@iastate.edu}> 
}


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
