function VBC=nodesVBC(simulation,nodes)
%Get variable boundary defining nodes
folder=pwd; 

fid = fopen([folder simulation '1\DOMAIN.dat'], 'r');%CHECK that this file is updated!!!
i = 1;
lines{i} = fgets(fid);
while ischar(lines{i})
    i = i + 1;
    lines{i} = fgets(fid);
end
fclose(fid);
%builds a vector with the nodes at the VBC
VBC=[];
for ind = 7 : nodes+6
    v= lines{ind};
    C=strsplit(v,' ');
    
    if C{3}=='1'
      VBC=[VBC str2num(C{2})];
    end
end
end