function [realtime,runN]=mainCodeF_ET(simulation,fnameI,nodes,P1,V1,CO2i,realInitialT,VBC,atmosphAll)
tic
folder=pwd;
j=0;
fname=([folder simulation]);
%loading the structure with the data from previous simulations
if exist('finalresults.mat','file')==[2],
    load('finalresults.mat');
else
    finalresults=resultsInitial(fnameI);
end
%-------------------------------------------------------------------------
files=dir([fname '*']);
fileN=size(files,1);
time=fileN;
%getting ready for first simulation
domain_initial(fname,fnameI,'1',nodes,P1)
realtime=realInitialT+1;
atmosphF_ET(fname, '1',realtime,atmosphAll);
domainChemInitial(fname,'1',fnameI)

[level01,message]=fopen([folder '\level_01.dir'],'w');
fwrite(level01,[fname '1']);
fclose(level01);
[status,results]=dos([folder '\H2D_Unsc.exe']);

pressH_BC(1,:)=P1;
cumV=0;
%Saving data from previous simulation
%if we don't have solutes then multiply by 6 instead of 10
%balance(1:10,:)=readBalance([fname '1']);
%[chemBalance(1:3,:),chemBalance_i_f(1:2,:)]=readChemBalance([fname '1']);
[v_mean(1,:),Run_inf(1,:),cumQ(1,:),atmosph(1,:)]=saveVar([fname '1'],1, nodes);
[solute1(1,:), solute2(1,:), solute3(1,:), solute4(1,:), solute5(1,:), solute6(1,:), solute7(1,:), solute8(1,:)]=saveSolute([fname '1'],1);
ObsN(1,:)=obsNod([fname '1'],1);
[cupConc(1,:),seepConc(1,:),irrConc(1,:)]=cupSolution(solute1, solute2, solute3, solute4, solute5, solute6, solute7, solute8,v_mean);

%Gets pressureHead for the boundary condition in next run
[targetH,cumV,V2]=getH(cumQ(1,:),cumV,V1,P1);
pressH_BC(1,:)=targetH;
volume(1,:)=cumV;
V2save(1,:)=V2;

%calculates pCO2 in atm as
%atmCO2(mol/mol)*(Patm+Pvacuum)*100/101325(from mbar to atm)
CO2=CO2i*(1013.25+pressH_BC)/1013.25;
[pHout,calcite,gypsum,equil_pH1,phreeqcR]=PHREEQC(volume, V1, [fname '1'], CO2, cupConc,1,nodes,VBC,j);

for k=2:time
    prevRunN=num2str(k-1);
    runN=num2str(k);
    %Writing Domain.dat file with updated values for next simulation
    %Look at the boundary condition pressure head
    domain_w(fname,prevRunN,runN,nodes,targetH)
    domainChem(fname,prevRunN,runN)
    realtime(k)=realInitialT+k;
    atmosphF_ET(fname,runN,realtime(k),atmosphAll);
    %run simulation
    [level01,message]=fopen([folder '\level_01.dir'],'w');
    fwrite(level01,[fname runN]);
    fclose(level01);
    [status,results]=dos([folder '\H2D_Unsc.exe']);
    display(k)
    %saving data from last simulation
    %balance((k-1)*10+1:k*10,:)=readBalance([fname runN]);
    %[chemBalance(((k-2)*3+1):((k-1)*3),:),chemBalance_i_f(((k-2)*2+1):((k-1)*2),:)]=readChemBalance([fname runN]);
    [v_mean(k,:),Run_inf(k,:),cumQ(k,:),atmosph(k,:)]=saveVar([fname runN],k,fname);
    [solute1(k,:), solute2(k,:), solute3(k,:), solute4(k,:), solute5(k,:), solute6(k,:), solute7(k,:), solute8(k,:)]=saveSolute([fname runN],k);
    ObsN(k,:)=obsNod([fname runN],k);
    [targetH,cumV]=getH(v_mean(k,:),cumV,V1,P1);
    pressH_BC(k,:)=targetH;
    volume(k,:)=cumV;
    %updates the solution concentration inside the suction cup
    [cupConc(k,:),seepConc(k,:),irrConc(k,:)]=cupSolution(solute1, solute2, solute3, solute4, solute5, solute6, solute7, solute8,v_mean);
    %runs chemistry inside the cup - gives the chemistry for each step
    CO2(k)=CO2i*(1013.25+pressH_BC(k))/1013.25;
    [pHout(k,:), calcite(k,:),gypsum(k,:),equil_pH1(k,:),phreeqcRr]=PHREEQC(volume, V1, [fname runN ], CO2, cupConc,k,nodes,VBC,j);
    phreeqcR=[phreeqcR ; phreeqcRr];
    %     [balance1D,chemBalance1D]=unsat1D(cupConc(k,:),folder,H1D,k,balance1D,chemBalance1D);
    %condition to keep running if water is still entering the cup
    if (volume(k)-volume(k-1))/(volume(2)-volume(1))<0.01
       %volume(k)>20 
        j=1;
        [pHout(k,:), calcite(k,:),gypsum(k,:),equil_pH1(k,:),phreeqcRr]=PHREEQC(volume, V1, [fname runN ], CO2, cupConc,k,nodes,VBC,j);
        break
    end
    fclose('all');
end
%save results from this vacuum event in external structure
data=[realtime', equil_pH1, pHout,volume,pressH_BC,CO2',calcite(:,6),gypsum(:,6)];
localresults.name=['P1' num2str(P1) 'CO2' num2str(CO2i) 'V1' num2str(V1)];
localresults.general_data=data;
localresults.atmosph=atmosph;
localresults.v_mean=v_mean;
localresults.cupConc=cupConc;
localresults.ObsN=ObsN;
localresults.seepConc=seepConc;
localresults.irrConc=irrConc;
localresults.phreeqcAll=phreeqcR;
finalresults=[finalresults,localresults];
save('finalresults','finalresults')
save(['results' 'P1' num2str(P1) 'CO2' num2str(CO2i) 'V1' num2str(V1) '.mat']);
toc
%load chirp, sound(y,2*Fs)
end