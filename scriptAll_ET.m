%========================================================================%
tic
cont=1;
%Define initial simulation H3D2_UNSAT_VBC_irr1h_initial. Manually set the
%pressure initial conditions and export input files as text of all simulations.
fnameI='\H3D2_UNSAT_VBC_RNegev_deep200_initial';
washRun='\H3D2_UNSAT_VBC_RNegev_deep200_washET';
contRun='\H3D2_UNSAT_VBC_RNegev_deep200_continue';
%name of the simulation without the "1"
simulation='\H3D2_UNSAT_VBC_RNegev_deep200_1min_';
%get the total number of nodes
nodes=nodesN(fnameI);
%initial pressure applied 1035(atmosph pressure)+negative vaccum.
P1=-100;                                                                             ;
%volume of the suction system chamber
V1=100;
%atmospheric CO2 concentration
CO2i=0.0004;
%time is the maximum time that the sampling is allowed. 
time=10;
days=3;
hourI=6;
irrDur=1;
hourS=6;
dayET=0.25;
ETi=6;
ETdur=12;
LF=2;
ETarea=10000;
irrArea=1257;
%build the matrix with the time variable boundary conditions for all the
%entire period
atmosphAll=buildAtmosphAll_ET(days,hourI,irrDur,hourS,dayET,ETdur,LF,ETarea,irrArea,ETi);
%get the number of nodes at the VBC
VBC=nodesVBC(simulation,nodes);
%runs initial simulation
realInitialT=runInitial(fnameI,washRun,atmosphAll);
%copy the simulation file the maximum number of minutes the sampling is
%allowed
folder=pwd;
for i=2:time
    copyfile([folder simulation '1'],[folder simulation num2str(i)])
end
while cont==1
    %function that runs the sampling event
[realtime,runN]=mainCodeF_ET(simulation,fnameI,nodes,P1,V1,CO2i,realInitialT,VBC,atmosphAll);
%function that runs a simulation in between sampling events
[cont,realInitialT,fnameI]=continueRun_ET(realtime,contRun,simulation,runN,nodes,atmosphAll);
end
resultsSolLongR=soluteDataLongR(contRun);
load('finalresults')

load train, sound(y,1*Fs)
toc