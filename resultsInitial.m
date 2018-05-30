function finalresultsI=resultsInitial(fnameI)
folder=pwd;
ObsN=obsNod([folder fnameI],1);

fid = fopen([folder fnameI '\v_mean.out'], 'r');
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

fid = fopen([folder fnameI '\atmosph.in'], 'r');
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

filesSol=dir([folder fnameI '\solute*.out']);
soluteK=[];
for k=1:8
    fnameSol=filesSol(k).name;
    fid = fopen([folder fnameI '\' fnameSol], 'r');
    i = 1;
    lines{i} = fgets(fid);
    while ischar(lines{i})
        i = i + 1;
        lines{i} = fgets(fid);
    end
    fclose(fid);
    data = [];
    for ind = 6 : i-2
        v = str2num(lines{ind});
        data = cat(1,data,v);
    end
    
    soluteK(:,(k*3-2):k*3)=[data(:,15),data(:,16),data(:,21)];
end
soluteK=[data(:,1) soluteK];

solutesClean=zeros(1,size(soluteK,2));
for k=1:(size(soluteK,1)-1)
    if mod(soluteK(k,1),1)==0 &&  soluteK(k,1)~=soluteK(k+1,1)
        solutesClean=[solutesClean ; soluteK(k,:)];
    end
end
solutesClean=[solutesClean;soluteK(end,:)];

solutesShort=[];
for j=1:(size(v_mean,1))
    solutesShort(j,:)=solutesClean(j*10+1,:);
end
irrShort=[];
seepageShort=[];
ScupShort=[];
for x=1:8
    irrShort(:,x)=solutesShort(:,(x*3)+1);
    seepageShort(:,x)=solutesShort(:,(x*3));
    ScupShort(:,x)=solutesShort(:,(x*3)-1);
end
irrQ=repmat(v_mean(:,11),1,8);
irrC=irrShort./irrQ;
seepQ=repmat(v_mean(:,8),1,8);
seepC=seepageShort./seepQ;
ScupQ=repmat(v_mean(:,7),1,8);
ScupC=ScupShort./ScupQ;

finalresultsI=struct('name', fnameI, 'general_data', 0,'atmosph',atmosph,'v_mean',v_mean,'cupConc',ScupC,'ObsN',ObsN,'seepConc',seepC,'irrConc',irrC,'phreeqcAll', 0);
end