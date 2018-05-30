function [cont,time,fnameI]=continueRun_ET(realtime,contRun,simulation,runN,nodes,atmosphAll)
%continue simulation after suction period
lastSim=realtime(end);
%load('atmosphAll');
pressI=find(atmosphAll(:,3)==-500);
folder=pwd;
%contRun='H3D2_UNSAT_VBC_irr1h_continue';
%from main code
%simulation='H3D2_UNSAT_Car_1min_';
%runN='291';
%nodes
for k=1:(size(pressI-1,1))
    if lastSim > pressI(k) && lastSim<pressI(k+1)
        nextSim=((pressI(k+1))-lastSim-1);
        longsimulation=[folder contRun num2str(k)];
        fnameI=[contRun num2str(k)];
        copyfile([folder contRun],longsimulation);
        fid=fopen([longsimulation '\selector.in'],'r');
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
        
        fid = fopen([longsimulation '\selector.in'], 'w');
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
        initialAtm=lastSim+1;
        finalAtm=((pressI(k+1)-1));
        atmVarBC=atmosphAll(initialAtm:finalAtm,:);
        at=zeros(nextSim,16);
        at(:,1)=1:nextSim;
        at(:,5)=10000;
        at(:,8)=atmVarBC(:,2);
        at(:,14)=atmVarBC(:,4);
        at(:,4)=atmVarBC(:,5);
        %at(:,16)=zeros(nextSim,1);
        espaciado = '%11.8f %11.8f %11.8f %11.8f %11.8f %11.8f %11.8f %11.10f %11.8f %11.8f %11.8f %11.8f %11.8f %11.8f %11.8f %11.8f \r\n';
        fid = fopen([longsimulation '\atmosph.in'], 'r');
        i = 1;
        linesat{i} = fgets(fid);
        while ischar(linesat{i})
            i = i + 1;
            linesat{i} = fgets(fid);
        end
        fclose(fid);
        fid = fopen([longsimulation '\atmosph.in'], 'w');
        v= linesat{4};
        C=strsplit(v,' ');
        C(2)={num2str(nextSim)};
        linesat{4}=strjoin(C);
        for ind = 1:7
            fprintf(fid, linesat{ind});
        end
        fprintf(fid,repmat(espaciado,1,size(at,2) -1),at');
        fprintf(fid, linesat{end-1});
        %set initial conditions for solutes
        domainChemContinue(folder,longsimulation,runN,simulation)
        %set initial conditions for pressure head
        domain_cont(folder,longsimulation,runN,simulation,nodes)
        %write the real time int he text file
        fid=fopen([longsimulation '\realtime.txt'],'w');
        time=(pressI(k+1)-1);
        fprintf(fid,'%d',time);
        %run long simulation in between "suction events"
        [level01,message]=fopen([folder '\level_01.dir'],'w');
        fwrite(level01,longsimulation);
        fclose(level01);
        [status,results]=dos([folder '\H2D_Unsc.exe']);
        cont=1;
    elseif lastSim>pressI(end)
        k=size(pressI,1);
        final=size(atmosphAll,1);
        nextSim=(final-lastSim);
        longsimulation=[folder contRun num2str(k)];
        copyfile([folder contRun],longsimulation);
        fnameI=[contRun num2str(k)];
        fid=fopen([longsimulation '\selector.in'],'r');
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
        
        fid = fopen([longsimulation '\selector.in'], 'w');
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
        initialAtm=lastSim+1;
        atmVarBC=atmosphAll(initialAtm:final,:);
        at=zeros(nextSim,16);
        at(:,1)=1:nextSim;
        at(:,5)=10000;
        at(:,2)=atmVarBC(:,2);
        at(:,14)=atmVarBC(:,4);
        at(:,4)=atmVarBC(:,5);
        %at(:,16)=zeros(nextSim,1);
        espaciado = '%11.8f %11.8f %11.8f %11.8f %11.8f %11.8f %11.8f %11.10f %11.8f %11.8f %11.8f %11.8f %11.8f %11.8f %11.8f %11.8f \r\n';
        fid = fopen([longsimulation '\atmosph.in'], 'r');
        i = 1;
        linesat{i} = fgets(fid);
        while ischar(linesat{i})
            i = i + 1;
            linesat{i} = fgets(fid);
        end
        fclose(fid);
        fid = fopen([longsimulation '\atmosph.in'], 'w');
        v= linesat{4};
        C=strsplit(v,' ');
        C(2)={num2str(nextSim)};
        linesat{4}=strjoin(C);
        for ind = 1:7
            fprintf(fid, linesat{ind});
        end
        fprintf(fid,repmat(espaciado,1,size(at,2) -1),at');
        fprintf(fid, linesat{end-1});
        %set initial conditions for solutes
        domainChemContinue(folder,longsimulation,runN,simulation)
        %set initial conditions for pressure head
        domain_cont(folder,longsimulation,runN,simulation,nodes)
        %real time file
        fid=fopen([longsimulation '\realtime.txt'],'w');
        time=(final);
        fprintf(fid,'%d',time);
        %run long simulation in between "suction events"
        [level01,message]=fopen([folder '\level_01.dir'],'w');
        fwrite(level01,longsimulation);
        fclose(level01);
        [status,results]=dos([folder '\H2D_Unsc.exe']);
        cont=0;
        break
    end
        end
end