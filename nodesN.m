function nodes=nodesN(fnameI)
folder=pwd;

fid = fopen([folder fnameI '\DIMENSIO.IN'], 'r');%CHECK that this file is updated!!!
i = 1;
lines{i} = fgets(fid);
while ischar(lines{i})
    i = i + 1;
    lines{i} = fgets(fid);
end
fclose(fid);
v= lines{3};
    C=strsplit(v,' ');
    nodes=str2num(C{2});
end
