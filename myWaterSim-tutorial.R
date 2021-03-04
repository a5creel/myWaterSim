######################################################################################
# This script is a tutorial for the myWaterSim funciton which depends on the capn package 
# Written by Andie Creel
# Date: 3/04/2021
######################################################################################


# You will still need to load the data in from the capn code (lines 1-72 in groundwater_capn.R,
# I've deleted the comments to shorten it here)


library(capn)
#load required packages
if (!require("pacman")) install.packages("pacman") #pacman allows you to use the p_load function
p_load(capn, ggplot2, repmis)
rm(list=ls()) #clear workspace

## troubleshooting branch
gitbranch <- "master"

#----------------------------------------------------------------------------------------
# Get water data from Eli's Github
source_data(paste0("https://github.com/efenichel/capn_stuff/raw/",gitbranch,"/KSwater_data.RData")) #Rdata file upload
ksdata <- KSwater_data #save KSwater_data as ksdata 
rm(KSwater_data) #this removes the redundant data set. 

#----------------------------------------------------------------------------------------
# Get "datasetup" function to process data from Eli's github
source(paste0("https://github.com/efenichel/capn_stuff/raw/",gitbranch,"/data_setup.R"))


#------------------------------------------------------------------------------------------
# Get the system model associated with Fenichel et al. 2016 and Addicott & Fenichel 2019
# First load the functions 
# source('system_fns.R')  
#source a separate script from github that contains the functions for gw system
source(paste0("https://raw.githubusercontent.com/efenichel/capn_stuff/",gitbranch,"/system_fns.R")) #will need to fix in the end

# Setup gwdata data ------------------------------------------------------------------------------
my.region <- 7 #setting region at the state level

# After setting the region, create capn data structure
if (!exists("region")){region <- my.region} #default to state
region_data <- ksdata[[region]] #double-brackets here important. Load in region specific data
gw.data <- datasetup(dataset = ksdata, region)  #note there is option data setup dataset. Default is ksdata, but this can be changed.

#---------------------------------------------------------------------------------------------

#Import myWaterSim funciton from Andie's github
source("https://raw.githubusercontent.com/a5creel/myWaterSim/main/myWaterSim.R")

#Note: you can now click myWaterSim in the Global Environment, where it is listed under Functions, to see how it works
# It should look VERY SIMILAR to lines 74-135 of groundwater_capn.R

#myWaterSim returns the same object that psim returns, but you can adjust multiple variables quickly 
output1 <- myWaterSim(myDiscountRate = 0.03, myStock = 21.5, myRechargeMultiplier = 1, myQuest11 = FALSE, myGW.data = gw.data)
output2 <- myWaterSim()
output3 <- myWaterSim(myStock = 21.5)

output1$shadowp
output2$shadowp
output3$shadowp

cat("The above shadow prices are all the same, even though we used the myWaterSim function in three different ways")

# Note that output1 and output2 and output3 are the same. 
# Line 54 has the defaults listed out. 
# You do not need to enter the default value, shown by line 55
# You can enter some of the variables and not others, shown by line 56


# Why myWaterSim can be useful -------------------
# If you want to compare different discount rates, you can do so quickly. 
# Below is an example not in the pset

outputA <- myWaterSim(myStock = 40, myDiscountRate = 0.03)
outputB <- myWaterSim(myStock = 40, myDiscountRate = 0.07)

cat("Ex 1. Stock of water is 40 feet deep. 
    \n Shadow price when discount rate is 0.03: ", outputA$shadowp,
    "\n Shadow price when dicount rate is 0.07", outputB$shadowp)


# slightly more advanced (not needed for pset, but I find it useful) ---------------
# if you want to reduce the amount of variables in your environment, you can call the function directly
# rather than assigning it to an output variable. 

#Let's redo the above example

cat("Ex 2. Stock of water is 40 feet deep. 
    \n Shadow price when discount rate is 0.03: ", myWaterSim(myStock = 40, myDiscountRate = 0.03)$shadowp,
    "\n Shadow price when dicount rate is 0.07", myWaterSim(myStock = 40, myDiscountRate = 0.07)$shadowp)





