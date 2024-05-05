% Input Data for 16 element mesh
E = 30e6; % Young’s modulus
ne = 0.3; % Poisson’s ratio
D = E/(1-ne^2) * [ 1 ne 0
                   ne 1 0
                   0 0 (1-ne)/2];
% mesh specifications
nsd = 2; % number of space dimensions
nnp = 25; % number of nodal nodes
nel = 16; % number of elements
nen = 4; % number of element nodes
ndof = 2; % degrees-of-freedom per node
neq = nnp*ndof; % number of equations

f = zeros(neq,1); % initialize nodal force vector
d = zeros(neq,1); % initialize nodal displacement matrix
K = zeros(neq); % initialize stiffness matrix
flags = zeros(neq,1); % an array to set B.C flags
e_bc = zeros(neq,1); % essential B.C array
n_bc = zeros(neq,1); % natural B.C array
P = zeros(neq,1); % point forces applied at nodes
b = zeros(nen*ndof,nel); % body forces
ngp = 2; % number of gauss points in each direction
nd = 10; % number of dofs on essential boundary (x and y)

% essential B.C.
% nodes 1, 6, 11, 16, 21 have x and y displacement=0
ind1 = 1:10:(21-1)*ndof+1;
ind2 = 2:10:(21-1)*ndof+2;
flags(ind1) = 2; e_bc(ind1) = 0.0;
flags(ind2) = 2; e_bc(ind2) = 0.0;

% plots
compute_stress = 'yes';
plot_mesh = 'yes';
plot_nod = 'yes';
plot_disp = 'yes';
plot_disp_contour = 'yes';
print_stressStrain = 'yes';
plot_vonMises = 'yes';

% natural B.C - defined on edges
n_bc = [  21  22  23  24
          22  23  24  25
           0   0   0   0
         -20 -20 -20 -20
           0   0   0   0
         -20 -20 -20 -20];
nbe = 4; % number of edges on natural boundary

% mesh generation
mesh2d;