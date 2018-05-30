function [solute1, solute2, solute3, solute4, solute5, solute6, solute7, solute8]=saveSolute(fname,k)
fid = fopen([fname '\solute1.out'], 'r');
i = 1;
lines{i} = fgets(fid);
while ischar(lines{i})
    i = i + 1;
    lines{i} = fgets(fid);
end
fclose(fid);
solute1 = [];
v = str2num(lines{7});
solute1 = cat(1,solute1,v);
time=(k)';
solute1(:,1)=time;

fid = fopen([fname '\solute2.out'], 'r');
i = 1;
lines{i} = fgets(fid);
while ischar(lines{i})
    i = i + 1;
    lines{i} = fgets(fid);
end
fclose(fid);
solute2 = [];
v = str2num(lines{7});
solute2 = cat(1,solute2,v);
solute2(:,1)=time;

fid = fopen([fname '\solute3.out'], 'r');
i = 1;
lines{i} = fgets(fid);
while ischar(lines{i})
    i = i + 1;
    lines{i} = fgets(fid);
end
fclose(fid);
solute3 = [];
v = str2num(lines{7});
solute3 = cat(1,solute3,v);

solute3(:,1)=time;

fid = fopen([fname '\solute4.out'], 'r');
i = 1;
lines{i} = fgets(fid);
while ischar(lines{i})
    i = i + 1;
    lines{i} = fgets(fid);
end
fclose(fid);
solute4 = [];
v = str2num(lines{7});
solute4 = cat(1,solute4,v);

solute4(:,1)=time;

fid = fopen([fname '\solute5.out'], 'r');
i = 1;
lines{i} = fgets(fid);
while ischar(lines{i})
    i = i + 1;
    lines{i} = fgets(fid);
end
fclose(fid);
solute5 = [];
v = str2num(lines{7});
solute5 = cat(1,solute5,v);
solute5(:,1)=time;

fid = fopen([fname '\solute6.out'], 'r');
i = 1;
lines{i} = fgets(fid);
while ischar(lines{i})
    i = i + 1;
    lines{i} = fgets(fid);
end
fclose(fid);
solute6 = [];
v = str2num(lines{7});
solute6 = cat(1,solute6,v);
solute6(:,1)=time;

fid = fopen([fname '\solute7.out'], 'r');
i = 1;
lines{i} = fgets(fid);
while ischar(lines{i})
    i = i + 1;
    lines{i} = fgets(fid);
end
fclose(fid);
solute7 = [];
v = str2num(lines{7});
solute7 = cat(1,solute7,v);
solute7(:,1)=time;

fid = fopen([fname '\solute8.out'], 'r');
i = 1;
lines{i} = fgets(fid);
while ischar(lines{i})
    i = i + 1;
    lines{i} = fgets(fid);
end
fclose(fid);
solute8 = [];
v = str2num(lines{7});
solute8 = cat(1,solute8,v);
solute8(:,1)=time;
end