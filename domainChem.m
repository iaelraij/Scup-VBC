function domainChem(fname,prevRunN,runN)

%import the chemical initial conditions from a previous simulation
[options,message]=fopen([fname runN '\options.in'],'wt');
fprintf(options,'*** Options.in *********************************\n');
fprintf(options,'lReachChemI\n');
fprintf(options,'t\n');
fprintf(options,'cDataPath\n');
fwrite(options,[fname prevRunN]);
fprintf(options,'\n');
fprintf(options,'nTime\n');
fprintf(options,'2\n');
fprintf(options,'************************************************\n');
fclose(options);
end