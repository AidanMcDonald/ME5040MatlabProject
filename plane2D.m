%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2D Plane Stress                             %
% Aidan McDonald                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;
close all; 

% include global variables
include_flags;

% Preprocessing
[K,f,d] = preprocessor;

% Evaluate element conductance matrix, nodal load vector and assemble
for e = 1:nel
    [ke, fe] = plane2Delem(e); 
    [K,f] = assembly(K,f,e,ke,fe);
end

% Compute and assemble nodal boundary load vector and point loads
f = src_and_flux(f);

% Solution
[d,f_E] = solvedr(K,f,d);

% Postprocessor
postprocessor(d);
