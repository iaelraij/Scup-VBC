function [cupConc,seepConc,irrConc] = cupSolution(solute1, solute2, solute3, solute4, solute5, solute6, solute7, solute8,v_mean)

cumS=[sum(solute1,1);sum(solute2,1);sum(solute3,1);sum(solute4,1);sum(solute5,1);sum(solute6,1);sum(solute7,1);sum(solute8,1);];
cumVmean=sum(v_mean,1);

cupConc=(cumS(:,6)./cumVmean(:,7))';
seepConc=(cumS(:,7)./cumVmean(:,8))';
irrConc=(cumS(:,12)./cumVmean(:,11))';
end
