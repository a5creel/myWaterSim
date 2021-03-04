myWaterSim <-function(myDiscountRate =0.03, myStock = 21.5, myRechargeMultiplier = 1, myQuest11 = FALSE, myGW.data = gw.data){
  #State parameter
  s = myStock
  
  # User specified parameters ---------------------------------------------------------------
  #Economic parameters: function sets the discount reat (0.03 by default)
  dr <- myDiscountRate 
  
  #System parameters: units are inches per year constant rate, see line 52
  recharge <- region_data[['recharge']] * myRechargeMultiplier
  
  #capN parameters
  order <- 10 # approximaton order
  NumNodes <- 100 #number of nodes
  wmax <- region_data[['watermax']]  #This sets the the upper bound on water amount to consider, see line 40 
  
  
  # Prepare {capn} -------------------------------------------------------------------------
  
  #prepare capN
  Aspace <- aproxdef(order,0,wmax,dr) #defines the approximation space
  nodes <- chebnodegen(NumNodes,0,wmax) #define the nodes
  
  #prepare for simulation
  simuData <- matrix(0,nrow = NumNodes, ncol = 5)
  
  #simulate at nodes
  for(j in 1:NumNodes){
    simuData[j,1]<-nodes[j] #water depth nodes
    simuData[j,2]<-sdot(nodes[j],recharge,myGW.data) #change in stock over change in time
    simuData[j,3]<- 0-WwdDs1(nodes[j],myGW.data) # d(sdot)/ds, of the rate of change in the change of stock
    simuData[j,4]<-ProfDs1(nodes[j],myGW.data) #Change in profit with the change in stock
    simuData[j,5]<-profit(nodes[j],myGW.data) #profit
  }
  
  
  #recover approximating coefficents
  pC<-paprox(Aspace, simuData[,1],simuData[,2],simuData[,3],simuData[,4])  #the approximated coefficent vector for prices
  
  
  if (myQuest11 == FALSE) {
    output <- psim(pcoeff = pC, stock = s)
  } else{
  output <- psim(pcoeff = pC, stock = s,
                    wval = profit(s, myGW.data),
                    sdot = sdot(s, region_data[['recharge']], myGW.data) )
  }
  
  return(output)
}