# myWaterSim
This funciton can help with some of the questions on the problem set. It returns the same object as psim does, which we assigned to a variable called 'output'. 

I have set up default values. If you want to use the default, you don't need to change these. You could just run: 

output <- myWaterSim()

The defaults are:
- myDiscountRate = 0.03
- myStock = 21.5 # water depth
- myRechargeMultiplier = 1 #could halve the regard rate by setting myRechargeMultiplier = 0.5
- myQuest11 = FALSE # Set to true for parts of Q11 when we are asked about the vfun and sdot
- myGW.data = gw.data #set to gw.data.alt for later parts of the problem set


You can add this function to your own environment by running:

source("https://raw.githubusercontent.com/a5creel/myWaterSim/main/myWaterSim.R")
