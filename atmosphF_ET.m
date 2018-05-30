function realtime=atmosphF_ET(fname,runN,realtime,atmosphAll)
%load('atmosphAll');
% %reading what is the real time of this simulation
% fileID = fopen([fname runN '\realtime.txt'],'r');
% rlt=textscan(fileID,'%f');
% realtime=rlt{1};
%retrieveing from the atmAll file the variable boundary conditions for the
%real time
read_atmosphAll=atmosphAll(realtime,:);
%reading and saving the VBC in the relevent atmosph.in file
fid = fopen([fname runN '\atmosph.in'], 'r');
i = 1;
lines{i} = fgets(fid);
while ischar(lines{i})
    i = i + 1;
    lines{i} = fgets(fid);
end
fclose(fid);
v=lines{8};
C=strsplit(v,' ');
C(8)={'0'};
C(9)={num2str(read_atmosphAll(2))};
C(15)={num2str(read_atmosphAll(4))};
C(5)={num2str(read_atmosphAll(5))};
Cstr=strjoin(C);
lines{8}=Cstr;
fid = fopen([fname runN '\ATMOSPH.IN'], 'w');
for ind = 1:9
    fprintf(fid, lines{ind});
end
fclose(fid);
end