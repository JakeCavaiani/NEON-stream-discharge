##############################################################################################
#' @title Stage-Discharge Rating Curve Docker Script

#' @author 
#' Kaelin M. Cawley \email{kcawley@battelleecology.org} \cr

#' @description This script uses the BaM executable to calculate the parameters that define 
#' the stage-discharge relationship for a site and water year using NEON data.

#' @references
#' License: GNU AFFERO GENERAL PUBLIC LICENSE Version 3, 19 November 2007

#' @export

# changelog and author contributions / copyrights
#   Kaelin M. Cawley (2017-12-07)
#     original creation
##############################################################################################

# #For running the code outside of a Docker container
# #The paths can get pretty long (>260 characters),
# #which can cause trouble with the data stacker in windows, choose wisely.
# 
# #User inputs for site and date
# #If you enter a startData that is not YYY-10-01, the script will determine the
# #water year that started immediately before the date entered here and use it as the
# #startDate
# 
# Sys.setenv(DIRPATH = "C:/Users/kcawley/Documents/GitHub/NEON-stream-discharge/L4Discharge/",
#            BAMFOLD="BaM_beta/",
#            BAMFILE="BaM_MiniDMSL.exe",#Windows version
#            #BAMFILE="BaM_exe",#Linux version
#            DATAWS="C:/Users/kcawley/Desktop/data/",
#            BAMWS="BaM_beta/BaM_BaRatin/",
#            STARTDATE = "2016-10-01",
#            SITE = "HOPB")
# 
# DIRPATH = Sys.getenv("DIRPATH")
# BAMFOLD = Sys.getenv("BAMFOLD")
# BAMFILE = Sys.getenv("BAMFILE")
# DATAWS = Sys.getenv("DATAWS")
# BAMWS = Sys.getenv("BAMWS")
# startDate = Sys.getenv("STARTDATE")
# site = Sys.getenv("SITE")
# #Need to run this periodically if you're running the code outside of the Docker container
# #as NEON packages get updated
# library(devtools)
# install_github("NEONScience/NEON-utilities/neonUtilities", force = TRUE, dependencies = TRUE)
# install_github("NEONScience/NEON-stream-discharge/L4Discharge/stageQCurve", force = TRUE, dependencies = TRUE)
# #Load needed library for Docker testing prior to GitHub package release
# setwd("/app/L4_discharge/")
# devtools::install("stageQCurve")
# library(stageQCurve)

#Environment options and configurations
options(stringsAsFactors = F)
Sys.setenv(TZ='UTC')
library(neonUtilities)
library(stageQCurve)

#Run main function to create a rating curve
#The inputs are set as environment variables rather than R variables to allow for running the Docker container 
#for diffrent sites and dates without rebuilding it
calc.stag.Q.curv()

# #Plot rating curve prior and posterior parameter distributions
# #From MCMC outputs directly
# numCtrls <- nrow(read.table("~/GitHub/NEON-stream-discharge/L4Discharge/BaM_beta/BaM_BaRatin/Config_ControlMatrix.txt"))
# priorParams <- read.table("~/GitHub/NEON-stream-discharge/L4Discharge/BaM_beta/BaM_BaRatin/Config_Model.txt")
# Results_MCMC_Cooked <- read.table("~/GitHub/NEON-stream-discharge/L4Discharge/BaM_beta/BaM_BaRatin/Results_MCMC_Cooked.txt",header = T)
# pre.post.parm.plot(numCtrls,priorParams,Results_MCMC_Cooked,NEONformat=F)
# MCMC.sim.plot(numCtrls,Results_MCMC_Cooked,NEONformat=F)
# 
# #From downloaded NEON data
# #TBD: pre.post.parm.plot(numCtrls,priorParams,Results_MCMC_Cooked,NEONformat=T)
# 
# #From NEON transition download
# posteriorParameter <- read.table("~/GitHub/NEON-stream-discharge/L4Discharge/data/L1_Results_sdrc_posteriorParameters_pub.txt", header = T)
# resultsResiduals <- read.table("~/GitHub/NEON-stream-discharge/L4Discharge/data/L1_Results_sdrc_resultsResiduals_pub.txt", header = T)
# stageDischargeCurveInfo <- read.table("~/GitHub/NEON-stream-discharge/L4Discharge/data/L1_Results_sdrc_stageDischargeCurveInfo_pub.txt", header = T)
# sampledParameters <- read.table("~/GitHub/NEON-stream-discharge/L4Discharge/data/L1_Results_sdrc_sampledParameters_pub.txt", header = T)
# txt.out.spag.data(spagDataIn=sampledParameters, spagOutPath=paste0(DIRPATH, BAMWS, "Results_MCMC_Cooked.txt"))
# 
# numCtrls <- 3
# Results_MCMC_Cooked <- read.table("~/GitHub/NEON-stream-discharge/L4Discharge/BaM_beta/BaM_BaRatin/Results_MCMC_Cooked.txt",header = T)
# priorParams <- read.table("~/GitHub/NEON-stream-discharge/L4Discharge/BaM_beta/BaM_BaRatin/Config_Model.txt",header = F)
# 
# pre.post.parm.plot(numCtrls,priorParams,Results_MCMC_Cooked,NEONformat=F)
# MCMC.sim.plot(numCtrls,Results_MCMC_Cooked,NEONformat=F)
# 
# minH <- stageDischargeCurveInfo$minStage - abs(stageDischargeCurveInfo$minStage)
# maxH <- stageDischargeCurveInfo$maxStage + stageDischargeCurveInfo$maxStage*0.3
# 
# minH <- 0
# maxH <- 0.6
# 
# #Run BaM in prediction mode to get the information for the rating curve
# #Hgrid <- BaM.run.pred.RC(minH = -0.05,maxH = 0.4)
# Hgrid <- BaM.run.pred.RC(minH = minH,maxH = maxH)
# 
# #Plot and save figures of BaM rating curve prediction run
# BaM.RC.out.plot(Hgrid=Hgrid)
# 
# #Plot rating curve with gaugings data from NEON dowload




