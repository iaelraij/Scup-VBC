%% This function needs to be modified according to the format of the results 
%%of the phreeqc outfile-------%%

% [seepC_am50,ScupC_am50,time_am50,general_data_am50,ScupCf_am50,timeF_am50,obsNodf_am50,...
%     timePhreeqc_am50,Ca_am50,K_am50,Cl_am50,Mg_am50,Na_am50,S_am50,...
%     PHcup_am50,PHsoil_am50,calcite_am50,gypsum_am50,obsNodPhreeqTime_am50,v_mean_am50,ObsNlong_am50,avgObsNlong_am50,...
%     obsNchem_am50,ScupChem_am50]=readResultsFinal(finalresults_am50,...
%     resultsSolLongR_am50);

function [seepC,ScupC,time,general_data,ScupCf,timeF,obsNodf,timePhreeqc,Ca,K,Cl,...
    Mg,Na,Si,Cai,Ki,Cli,Mgi,Nai,SPHcup,PHsoil,calcite,gypsum,obsNodPhreeqTime,timePhreeqcLong,...
    CaLong,KLong,ClLong,MgLong,NaLong,SLong,CaLongi,KLongi,ClLongi,MgLongi,NaLongi,SLongi,v_mean,ObsNlong,avgObsNlong,...
    obsNchem,ScupChem]=readResultsFinal(finalresults,resultsSolLongR)
% load('finalresults')
% load('resultsSolLongR')
%sim='results_pm_V1_250_P-813again';
%load(sim)
seepC=finalresults(1).seepConc;
ScupC=finalresults(1).cupConc;
time=10.*(1:size(seepC,1))';
general_data=[];
ObsNlong=[];
v_mean=[];
for i=1:size(resultsSolLongR,2)
    %seepC
    seepCmin=finalresults(i+1).seepConc;
    seepClong=resultsSolLongR(i).seepC;
    seepC=[seepC ; seepCmin; seepClong];
    %ScupC
    ScupCmin=finalresults(i+1).cupConc;
    final=floor(size(finalresults(i+1).phreeqcAll,1)/10)*10;
    ScupCf(i,:)=finalresults(i+1).cupConc(final,:);
    timeF(i,:)=finalresults(i+1).general_data(final,1);
    %ScupCf(i,:)=finalresults(i+1).cupConc(end,:);
    %timeF(i,:)=finalresults(i+1).general_data(end,1);
    obsNodf(i,:)=finalresults(i+1).ObsN(final,:);
    ScupClong=resultsSolLongR(i).ScupC;
    ScupC=[ScupC; ScupCmin; ScupClong];
    %gerneraldata %time
    general=finalresults(i+1).general_data;
    obs=finalresults(i+1).ObsN;
    ObsNlong=[ObsNlong ;obs];
    general_data=[general_data ; general];
    vmean=finalresults(i+1).v_mean;
    v_mean=[v_mean ; vmean];
    time=[time ; general(:,1)];
    for j=1:size(seepClong,1)
        time=[time ;time(end)+10];
    end
end
time(:,2)=time/60/24;
timeF(:,2)=timeF(:,1)/60/24;
%==============PHREEQC solute concentrations==============================
structure2=struct('Ca', 0,'Cl', 0,'K',0,'Mg',0,'Na',0,'S', 0);
structure2i=struct('Ca', 0,'Cl', 0,'K',0,'Mg',0,'Na',0,'S', 0);
for i=2:size(finalresults,2)
    
       % ind=index(j).line;
       %for 
        k=floor(size(finalresults(i).phreeqcAll,1)/10); 
        for j=203:208
            %c=finalresults(i).phreeqcAll(k*10).resultsPH(ind).resultsPH;
            c=finalresults(i).phreeqcAll(k*10).resultsPH(j).resultsPH;
            v(j-202,:)=strsplit(c,' ');
        end
        
%         for j=49:54
%             %c=finalresults(i).phreeqcAll(k*10).resultsPH(ind).resultsPH;
%             ci=finalresults(i).phreeqcAll(k*10).resultsPH(j).resultsPH;
%             vi(j-48,:)=strsplit(ci,' ');
%         end
        
        structure1=struct(strtrim(v{1,1}),str2num(v{1,2}),...
            strtrim(v{2,1}),str2num(v{2,2}),...
            strtrim(v{3,1}),str2num(v{3,2}),...
            strtrim(v{4,1}),str2num(v{4,2}),...
            strtrim(v{5,1}),str2num(v{5,2}),...
            strtrim(v{6,1}),str2num(v{6,2}));
        structure2=[structure2 structure1];
        
        structure1i=struct(strtrim(v{1,1}),str2num(v{1,2}),...
            strtrim(v{2,1}),str2num(v{2,2}),...
            strtrim(v{3,1}),str2num(v{3,2}),...
            strtrim(v{4,1}),str2num(v{4,2}),...
            strtrim(v{5,1}),str2num(v{5,2}),...
            strtrim(v{6,1}),str2num(v{6,2}));
        structure2i=[structure2i structure1i];
    %end
    timePhreeqc(i)=finalresults(i).general_data(k*10,1);
    PHcup(i-1)=finalresults(i).general_data(k*10,3);
    PHsoil(i-1)=finalresults(i).general_data(k*10,2);
    calcite(i-1)=finalresults(i).general_data(k*10,7);
    gypsum(i-1)=finalresults(i).general_data(k*10,8);
    obsNodPhreeqTime(i-1,:)=finalresults(i).ObsN(k*10,:);
    
end
timePhreeqc(2,:)=timePhreeqc(1,:)/60/24;
%end
for i=1:size(structure2,2)
    Ca(i)=structure2(i).Ca;
    Cl(i)=structure2(i).Cl;
    K(i)=structure2(i).K;
    Mg(i)=structure2(i).Mg;
    Na(i)=structure2(i).Na;
    S(i)=structure2(i).S;
end
for i=1:size(structure2i,2)
    Cai(i)=structure2i(i).Ca;
    Cli(i)=structure2i(i).Cl;
    Ki(i)=structure2i(i).K;
    Mgi(i)=structure2i(i).Mg;
    Nai(i)=structure2i(i).Na;
    Si(i)=structure2i(i).S;
end
Ca(:,1)=[];
Mg(:,1)=[];
S(:,1)=[];
Cl(:,1)=[];
K(:,1)=[];
Na(:,1)=[];
Ca(2,:)=Ca(1,:).*2000;
Mg(2,:)=Mg(1,:).*2000;
S(2,:)=S(1,:).*2000;
Cl(2,:)=Cl(1,:).*1000;
Na(2,:)=Na(1,:).*1000;
K(2,:)=K(1,:).*1000;

Cai(:,1)=[];
Mgi(:,1)=[];
Si(:,1)=[];
Cli(:,1)=[];
Ki(:,1)=[];
Nai(:,1)=[];
Cai(2,:)=Cai(1,:).*2000;
Mgi(2,:)=Mgi(1,:).*2000;
Si(2,:)=Si(1,:).*2000;
Cli(2,:)=Cli(1,:).*1000;
Nai(2,:)=Nai(1,:).*1000;
Ki(2,:)=Ki(1,:).*1000;
%++++++++Saving all the solute concentrations in each vacuum event+++++++++
timePhreeqcLong=[];
structure2long=struct('Ca', 0,'Cl', 0,'K',0,'Mg',0,'Na',0,'S', 0);
timePhreeqcLongi=[];
structure2longi=struct('Ca', 0,'Cl', 0,'K',0,'Mg',0,'Na',0,'S', 0);
for i=2:size(finalresults,2)
for k=1:floor(size(finalresults(i).phreeqcAll,1)/10);
for j=203:208
    %c=finalresults(i).phreeqcAll(k*10).resultsPH(ind).resultsPH;
    c=finalresults(i).phreeqcAll(k*10).resultsPH(j).resultsPH;
    v(j-202,:)=strsplit(c,' ');
end
structure1long=struct(strtrim(v{1,1}),str2num(v{1,2}),...
    strtrim(v{2,1}),str2num(v{2,2}),...
    strtrim(v{3,1}),str2num(v{3,2}),...
    strtrim(v{4,1}),str2num(v{4,2}),...
    strtrim(v{5,1}),str2num(v{5,2}),...
    strtrim(v{6,1}),str2num(v{6,2}));
structure2long=[structure2long structure1long];
timePhreeqcLong=[timePhreeqcLong finalresults(i).general_data(k*10,1)];

for h=49:54
    %c=finalresults(i).phreeqcAll(k*10).resultsPH(ind).resultsPH;
    ci=finalresults(i).phreeqcAll(k*10).resultsPH(h).resultsPH;
    vi(h-48,:)=strsplit(ci,' ');
end
structure1long=struct(strtrim(vi{1,1}),str2num(vi{1,2}),...
    strtrim(vi{2,1}),str2num(vi{2,2}),...
    strtrim(vi{3,1}),str2num(vi{3,2}),...
    strtrim(vi{4,1}),str2num(vi{4,2}),...
    strtrim(vi{5,1}),str2num(vi{5,2}),...
    strtrim(vi{6,1}),str2num(vi{6,2}));
structure2longi=[structure2longi structure1longi];
timePhreeqcLongi=[timePhreeqcLongi finalresults(i).general_data(k*10,1)];
end
end
for i=1:size(structure2long,2)
    CaLong(i)=structure2long(i).Ca;
    ClLong(i)=structure2long(i).Cl;
    KLong(i)=structure2long(i).K;
    MgLong(i)=structure2long(i).Mg;
    NaLong(i)=structure2long(i).Na;
    SLong(i)=structure2long(i).S;
end
for i=1:size(structure2longi,2)
    CaLongi(i)=structure2longi(i).Ca;
    ClLongi(i)=structure2longi(i).Cl;
    KLongi(i)=structure2longi(i).K;
    MgLongi(i)=structure2longi(i).Mg;
    NaLongi(i)=structure2longi(i).Na;
    SLongi(i)=structure2longi(i).S;
end
CaLong(:,1)=[];
MgLong(:,1)=[];
SLong(:,1)=[];
ClLong(:,1)=[];
KLong(:,1)=[];
NaLong(:,1)=[];
CaLong(2,:)=CaLong(1,:).*2000;
MgLong(2,:)=MgLong(1,:).*2000;
SLong(2,:)=SLong(1,:).*2000;
ClLong(2,:)=ClLong(1,:).*1000;
NaLong(2,:)=NaLong(1,:).*1000;
KLong(2,:)=KLong(1,:).*1000;
CaLongi(:,1)=[];
MgLongi(:,1)=[];
SLongi(:,1)=[];
ClLongi(:,1)=[];
KLongi(:,1)=[];
NaLongi(:,1)=[];
CaLongi(2,:)=CaLongi(1,:).*2000;
MgLongi(2,:)=MgLongi(1,:).*2000;
SLongi(2,:)=SLongi(1,:).*2000;
ClLongi(2,:)=ClLongi(1,:).*1000;
NaLongi(2,:)=NaLongi(1,:).*1000;
KLongi(2,:)=KLongi(1,:).*1000;
%=====================================================================
%---------Averaging observation nodes-------------------%
nodeNumber=((size(obsNodf,2))-1)/11;
for k=1:size(obsNodf,1)

for j=1:nodeNumber
obs2(j,:)=obsNodf(k,((11*(j-1))+2):(11*j+1));
h_long(:,j)=ObsNlong(:,(11*(j-1))+2);
th_long(:,j)=ObsNlong(:,(11*(j-1))+3);
temp_long(:,j)=ObsNlong(:,(11*(j-1))+4);
Ca_long(:,j)=ObsNlong(:,(11*(j-1))+5);
Mg_long(:,j)=ObsNlong(:,(11*(j-1))+6);
Na_long(:,j)=ObsNlong(:,(11*(j-1))+7);
K_long(:,j)=ObsNlong(:,(11*(j-1))+8);
alk_long(:,j)=ObsNlong(:,(11*(j-1))+9);
S_long(:,j)=ObsNlong(:,(11*(j-1))+10);
Cl_long(:,j)=ObsNlong(:,(11*(j-1))+11);

end
avgObsN(k,:)=mean(obs2);
end
avgObsNlong(:,1)=general_data(:,1);
avgObsNlong(:,2)=mean(h_long,2);
avgObsNlong(:,3)=mean(th_long,2);
avgObsNlong(:,4)=mean(temp_long,2);
avgObsNlong(:,5)=mean(Ca_long,2);
avgObsNlong(:,6)=mean(Mg_long,2);
avgObsNlong(:,7)=mean(Na_long,2);
avgObsNlong(:,8)=mean(K_long,2);
avgObsNlong(:,9)=mean(alk_long,2);
avgObsNlong(:,10)=mean(S_long,2);
avgObsNlong(:,11)=mean(Cl_long,2);
%building a structure with all the data for each sampling event for the
%observation nodes
obsNchem=struct('time',[],'h',[],'th',[],'temp',[],'Ca',[],'Mg',[],'Na',[],...
    'K',[],'alk',[],'S',[],'Cl',[]);
for i=1:size(resultsSolLongR,2)
 obs3=finalresults(i+1).ObsN;
 h_long2=[];
 th_long2=[];
 temp_long2=[];
 Ca_long2=[];
 Mg_long2=[];
 Na_long2=[];
 K_long2=[];
 alk_long2=[];
 S_long2=[];
 Cl_long2=[];
 for j=1:nodeNumber
h_long2(:,j)=obs3(:,(11*(j-1))+2);
th_long2(:,j)=obs3(:,(11*(j-1))+3);
temp_long2(:,j)=obs3(:,(11*(j-1))+4);
Ca_long2(:,j)=obs3(:,(11*(j-1))+5);
Mg_long2(:,j)=obs3(:,(11*(j-1))+6);
Na_long2(:,j)=obs3(:,(11*(j-1))+7);
K_long2(:,j)=obs3(:,(11*(j-1))+8);
alk_long2(:,j)=obs3(:,(11*(j-1))+9);
S_long2(:,j)=obs3(:,(11*(j-1))+10);
Cl_long2(:,j)=obs3(:,(11*(j-1))+11);
 end
obsNchem(i).time=finalresults(i+1).general_data(:,1);
obsNchem(i).h=mean(h_long2,2);
obsNchem(i).th=mean(th_long2,2);
obsNchem(i).temp=mean(temp_long2,2);
obsNchem(i).Ca=mean(Ca_long2,2);
obsNchem(i).Mg=mean(Mg_long2,2);
obsNchem(i).Na=mean(Na_long2,2);
obsNchem(i).K=mean(K_long2,2);
obsNchem(i).alk=mean(alk_long2,2);
obsNchem(i).S=mean(S_long2,2);
obsNchem(i).Cl=mean(Cl_long2,2);
end

Ca(3,:)=[avgObsN(:,4)' ];
Mg(3,:)=[avgObsN(:,5)' ];
Na(3,:)=[avgObsN(:,6)' ];
K(3,:)=[avgObsN(:,7)' ];
S(3,:)=[avgObsN(:,9)' ];
Cl(3,:)=[avgObsN(:,10)' ];
% Ca(3,:)=[avgObsN(:,4)' 0];
% Mg(3,:)=[avgObsN(:,5)' 0];
% Na(3,:)=[avgObsN(:,6)' 0];
% K(3,:)=[avgObsN(:,7)' 0];
% S(3,:)=[avgObsN(:,9)' 0];
% Cl(3,:)=[avgObsN(:,10)' 0];
Ca(4,:)=[Ca(2,:)./Ca(3,:)];
Mg(4,:)=(Mg(2,:)./Mg(3,:));
Na(4,:)=(Na(2,:)./Na(3,:));
K(4,:)=(K(2,:)./K(3,:));
S(4,:)=(S(2,:)./S(3,:));
Cl(4,:)=(Cl(2,:)./Cl(3,:));
v_mean(:,1)=general_data(:,1);
%save(sim)

%===building structure with all the daily values of the chemistry inside
%the suction cup 'ScupChem'
timePhreeqcDay=[];
ScupChem=struct('time',[],'Ca',[],'Mg',[],'Na',[],'K',[],'S',[],'Cl',[]);
for i=2:size(finalresults,2)
    CaDay=[];
    ClDay=[];
    KDay=[];
    MgDay=[];
    NaDay=[];
    SDay=[];
    timePhreeqcDay=[];
    structure2long=struct('Ca', 0,'Cl', 0,'K',0,'Mg',0,'Na',0,'S', 0);
for k=1:floor(size(finalresults(i).phreeqcAll,1)/10);
    for j=203:208
    %c=finalresults(i).phreeqcAll(k*10).resultsPH(ind).resultsPH;
    c=finalresults(i).phreeqcAll(k*10).resultsPH(j).resultsPH;
    v(j-202,:)=strsplit(c,' ');
end
structure1long=struct(strtrim(v{1,1}),str2num(v{1,2}),...
    strtrim(v{2,1}),str2num(v{2,2}),...
    strtrim(v{3,1}),str2num(v{3,2}),...
    strtrim(v{4,1}),str2num(v{4,2}),...
    strtrim(v{5,1}),str2num(v{5,2}),...
    strtrim(v{6,1}),str2num(v{6,2}));
structure2long=[structure2long structure1long];
timePhreeqcDay=[timePhreeqcDay finalresults(i).general_data(k*10,1)];
   
for f=2:size(structure2long,2)
    CaDay(f-1)=structure2long(f).Ca;
    ClDay(f-1)=structure2long(f).Cl;
    KDay(f-1)=structure2long(f).K;
    MgDay(f-1)=structure2long(f).Mg;
    NaDay(f-1)=structure2long(f).Na;
    SDay(f-1)=structure2long(f).S;
end
end
ScupChem(i-1).time=timePhreeqcDay';
ScupChem(i-1).Ca=CaDay.*2000';
ScupChem(i-1).Mg=MgDay.*2000';
ScupChem(i-1).Na=NaDay.*1000';
ScupChem(i-1).K=KDay.*1000';
ScupChem(i-1).S=SDay.*2000';
ScupChem(i-1).Cl=ClDay.*1000';
end
% for i=2:size(finalresults,2)
%     PHcup180(i-1)=finalresults(i).general_data(180,3);
% end

end