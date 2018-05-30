# Scup VBC
Readme 
Variable boundary condition with root water uptake

Four HYDRUS (2D/3D) simulation files are needed:
All files should have the same exact FE mesh, root distribution, upper and lower boundary conditions. The boundary condition at the suction cup is defined for each simulation. In the present code, irrigation is applied from an upper boundary condition ‘Variable Flux 2’. Length units ‘cm’. Uncheck “Press enter at the end”. 
1)	washRun – a relatively long simulation that brings the system to a place where the soil solution sampling will begin. Boundary condition at the suction cup: no flow. Time units can be chosen.
2)	fnameI – the initial simulation at day 1, time 00:01, it will run until vacuum application. Boundary condition at the suction cup: no flow. Time units ‘min’. Uncheck T-level information. Interval output of 10 min.
3)	contRun – this is the simulation that runs between the sampling periods. Boundary condition at the suction cup: no flow. Time units ‘min’. Uncheck T-level information. Interval output of 10 min.
4)	simulation – one minute simulation for each time step of the suction cup sampling event. The name of this simulation should be ‘\H3D2_something_1’, where there should be a number of files ‘\H3D2_something_1’ to ‘\H3D2_something_n’, where n is the maximum time in minutes that the sampling should continue. Boundary condition at the suction cup: constant head. Time units ‘min’. Uncheck T-level information. Interval output of 1 min.

Building the time variable boundary conditions function ‘buildAtmosphAll_ET’:
This matrix includes the irrigation, ET and vacuum application time.

Inputs:
1)	Days – number of days that sampling is performed
2)	hourI – time of the day, in hours, at which the irrigation starts
3)	irrDur – duration of the irrigation event in hours
4)	hourS – time of the day, in hours, at which the vacuum is applied. 
5)	dayET – day ET in cm/day
6)	ETdur – duration of ET in hours (suggested 12 hours)
7)	LF – leaching fraction as in Irrigation=ET*LF
8)	ETarea – surface area associated with transpiration, as defined at the Time Variable Boundary Conditions in the simulations in cm2 .
9)	irrArea – actual area of irrigation at the variable flux 2 in cm2. 
10)	ETi – time in hours that the 12 hour ET begins (suggested 6am)
Other inputs at the scriptAll_ET script:
1)	P1 – initial pressure applied at the VBC in cm
2)	V1 – the total volume of the suction cup system in cm3
3)	CO2i – atmospheric CO2 concentration in mol/mol
4)	time – maximum time in minutes allowed for the suction cup sampling

Functions to be called:

runInitial – runs initial simulation
nodesN – gets the total number of nodes
nodesVBC – gets the number of nodes at the VBC (constant head)
buildAtmosphAll_ET - build the matrix with the time variable boundary conditions for all the entire period
mainCodeF_ET - function that runs the sampling event
resultsInitial – saves one time the results from the initial simulation
domain_initial - this function reads the previous run final water content and concentration (if standard solute transport is considered) in the profile and re-writes them as initial conditions in the next run
atmosphF_ET – writes variable boundary conditions in first simulation
domainChemInitial – imports the chemical initial conditions from a previous simulation (UNSATCHEM)
saveVar – saving outputs water flow
saveSolute – saving each solute outflow
cupSolution – separate each type of outflow and puts together all solutes
obsNod – saves data from observation nodes
getH - Gets pressure Head for the boundary condition in next run
PHREEQC – runs chemical equilibrium inside the cup with PHREEQC
domain_w – like domain initial but in the loop
domainChem – like domainChemInitial but in the loop
continueRun_ET - continue simulation after suction period
domainChemContinue – initial solute distribution for simulation in between sampling events
domain_cont – initial pressure heads for simulation in between sampling events
soluteDataLongR – save results from simulations in between sampling events
mainCodeF_ET – runs one sampling event, from initial vacuum application until either no more water goes into the cup or the defined maximum sampling time arrives

Extra files:
1)	HYDRUS (2D/3D) + UNSATCHEM batch file
2)	PHREEQC batch file
3)	‘phreeqcFile.File’ input file for PHREEQC
4)	‘level_01.dir’ file for running HYDRUS in batch 
5)	Pos_data – vector with 720 values between 0 and 1 with a sinusoidal distribution (half a period)

 











