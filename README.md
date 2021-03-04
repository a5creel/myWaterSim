# myWaterSim
This funciton can help with some of the questions on the problem set. It returns the same object as psim does, which we assigned to a variable called 'output'. 

I have set up default values. If you want to use the default, you don't need to change these. You could just run: 

output <- myWaterSim() 

which is the same as running: 

output <- myWaterSim(myDiscountRate = 0.03, myStock = 21.5, myRechargeMultiplier = 1, myQuest11 = FALSE, myGW.data = gw.data)

The defaults are:
- myDiscountRate = 0.03
- myStock = 21.5 **water depth**
- myRechargeMultiplier = 1 **could halve the recharge rate by setting myRechargeMultiplier = 0.5**
- myQuest11 = FALSE **Set to TRUE in order to set psim(...,**
                    **wval = profit(s, myGW.data),**
                    **sdot = sdot(s, region_data[['recharge']],...)**
- myGW.data = gw.data **set to gw.data.alt for later parts of the problem set**


You can add this function to your own environment by running:

source("https://raw.githubusercontent.com/a5creel/myWaterSim/main/myWaterSim.R")


Look at myWaterSim-tutorial.R for some brief examples on how the function can be used. 

