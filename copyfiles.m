function copyfiles(simulation,time)
folder=pwd;
%initial='H3D2_UNSAT_VBC_RNegev_deep150_initial';
min1File='H3D2_UNSAT_VBC_irr1h_1min_1';
fileN='H3D2_UNSAT_VBC_irr1h_1min_';
% % fileID = fopen([initial '\realtime.txt'],'r');
% % rlt=textscan(fileID,'%f');
% realtime=rlt{1};

for i=1:time
    copyfile(min1File,[fileN num2str(i)])
end

end

