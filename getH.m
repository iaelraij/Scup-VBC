
function [targetH,cumV,V2]=getH(v_mean,cumV,V1,P1)
 newV=v_mean(:,7);
 cumV=cumV+newV;
 V2=V1-cumV;
 P2=((1035+P1)*V1)/V2;
 targetH=P2-1035;
end