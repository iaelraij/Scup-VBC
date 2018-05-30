function domainChemContinue(folder ,longsimulation,runN,simulation)

%import the chemical initial conditions from a previous simulation
[options,message]=fopen([longsimulation '\options.in'],'wt');
fprintf(options,'*** Options.in *********************************\n');
fprintf(options,'lReachChemI\n');
fprintf(options,'t\n');
fprintf(options,'cDataPath\n');
fwrite(options,[folder simulation runN]);
fprintf(options,'\n');
fprintf(options,'nTime\n');
fprintf(options,'2\n');
fprintf(options,'************************************************\n');
fclose(options);
end