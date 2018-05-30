function [nextSim]=runInitial(initial,washRun,atmosphAll)
%initial pressure head and solute conditions are manually set.
%setting the variable boundary conditions and time
%load('atmosphAll');
folder=pwd;
%getting the number of time prints in the wash run
fid=fopen([folder washRun '\selector.in'],'r');
i = 1;
linesb{i} = fgets(fid);
while ischar(linesb{i})
    i = i + 1;
    linesb{i} = fgets(fid);
end
fclose(fid);
v3=linesb{29};
C=strsplit(v3,' ');
time=C{9};
time2=str2num(time);
time3=num2str(time2+1);
%import the chemical initial conditions from a previous simulation
[options,message]=fopen([folder initial '\options.in'],'wt');
fprintf(options,'*** Options.in *********************************\n');
fprintf(options,'lReachChemI\n');
fprintf(options,'t\n');
fprintf(options,'cDataPath\n');
fwrite(options,[folder washRun]);
fprintf(options,'\n');
fprintf(options,'nTime\n');
fprintf(options,time3);
fprintf(options,'\n');
fprintf(options,'************************************************\n');
fclose(options);
%%======================================================================%%

pressI=find(atmosphAll(:,3)==-500);
nextSim=(pressI(1)-1);
fid=fopen([folder initial '\selector.in'],'r');
i = 1;
lines{i} = fgets(fid);
while ischar(lines{i})
    i = i + 1;
    lines{i} = fgets(fid);
end
fclose(fid);

v=lines{31};
A=strsplit(v,' ');
A(3)={[num2str(nextSim)]};
Astr=strjoin(A);
lines{31}=Astr;

v2=lines{33};
B=strsplit(v2,' ');
B(2)={num2str(nextSim)};
Bstr=strjoin(B,' ');
lines{33}=Bstr;

fid = fopen([folder initial '\selector.in'], 'w');
for ind = 1:30
    fprintf(fid,lines{ind});
end
fprintf(fid,'%s\r\n',Astr);
fprintf(fid,lines{32});
fprintf(fid,'%s',Bstr);
for ind = 34:size(lines,2)-1
    fprintf(fid,lines{ind});
end
fclose(fid);
atmVarBC=atmosphAll(1:nextSim,:);
at=zeros(nextSim,16);
at(:,1)=1:nextSim;
        at(:,5)=10000;
        at(:,8)=atmVarBC(:,2);
        at(:,14)=atmVarBC(:,4);
        at(:,4)=atmVarBC(:,5);
        at(:,16)=zeros(nextSim,1);
espaciado = '%11.8f %11.8f %11.8f %11.8f %11.8f %11.8f %11.8f %11.10f %11.8f %11.8f %11.8f %11.8f %11.8f %11.8f %11.8f %11.8f \r\n';
fid = fopen([folder initial '\atmosph.in'], 'r');
i = 1;
linesat{i} = fgets(fid);
while ischar(linesat{i})
    i = i + 1;
    linesat{i} = fgets(fid);
end
fclose(fid);
fid = fopen([folder initial '\atmosph.in'], 'w');
v= linesat{4};
C=strsplit(v,' ');
C(2)={num2str(nextSim)};
linesat{4}=strjoin(C);
for ind = 1:7
    fprintf(fid, linesat{ind});
end
fprintf(fid,repmat(espaciado,1,size(at,2) -1),at');
fprintf(fid, linesat{end-1});

%write the real time int he text file
fid=fopen([folder initial '\realtime.txt'],'w');
fprintf(fid,'%d',nextSim);

folder=pwd;
[level01,message]=fopen([folder '\level_01.dir'],'w');
fwrite(level01,[folder initial]);
fclose(level01);
[status,results]=dos([folder '\H2D_Unsc.exe']);
end
