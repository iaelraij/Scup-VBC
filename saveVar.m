function[v_mean,Run_inf,cumQ,atmosph]=saveVar(fname,k,nodes)

fid = fopen([fname '\v_mean.out'], 'r');
i = 1;
lines{i} = fgets(fid);
while ischar(lines{i})
    i = i + 1;
    lines{i} = fgets(fid);
end
fclose(fid);
v_mean = [];
for ind = 14 : i-2
    v = str2num(lines{ind});
    v_mean = cat(1,v_mean,v);
end
time=(k)';
v_mean(:,1)=time;

%     fid = fopen([fname '\solute1.out'], 'r');
%     i = 1;
%     lines{i} = fgets(fid);
%     while ischar(lines{i})
%         i = i + 1;
%         lines{i} = fgets(fid);
%     end
%     fclose(fid);
%     solute=[];
%     for ind = 6 : i-2
%         v = str2num(lines{ind});
%         solute = cat(1,solute,v);
%     end
%        solute(:,1)=time;

fid = fopen([fname '\cum_Q.out'], 'r');
i = 1;
lines{i} = fgets(fid);
while ischar(lines{i})
    i = i + 1;
    lines{i} = fgets(fid);
end
fclose(fid);
cumQ=[];
for ind = 14 : i-2
    v = str2num(lines{ind});
    cumQ = cat(1,cumQ,v);
end
cumQ(:,1)=time;

fid = fopen([fname '\atmosph.in'], 'r');
i = 1;
lines{i} = fgets(fid);
while ischar(lines{i})
    i = i + 1;
    lines{i} = fgets(fid);
end
fclose(fid);
atmosph=[];
for ind = 8 : i-2
    v = str2num(lines{ind});
    atmosph = cat(1,atmosph,v);
end
atmosph(:,1)=time;

%saving Run_Inf for last time step-----------------------------------------
run= fopen([fname '\Run_Inf.out'], 'r');
i = 1;
lines_run{i} = fgets(run);
while ischar(lines_run{i})
    i = i + 1;
    lines_run{i} = fgets(run);
end
fclose(run);
Run_inf=[];
for ind = 5 : i-2
    v = str2num(lines_run{1,ind});
    Run_inf = cat(1,Run_inf,v);
end
end


