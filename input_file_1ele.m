% Input Data for 1 element mesh

global ndof nnp nel nen nsd neq ngp nee neq
global nd e_bc b P D
global LM ID IEN flags n_bc 
global x y nbe
global compute_force plot_mesh plot_disp plot_disp_contour plot_nod

             
% material properties
E  = 3e7;        % Young's modulus
nu = .3;       % Poisson's ratio
D  = E/(1-nu^2)*[1 nu 0;nu 1 0;0 0 (1-nu)/2]; % conduction matrix

% mesh specifications
nsd  = 2;         % number of space dimensions
nnp  = 4;         % number of nodal nodes
nel  = 1;         % number of elements
nen  = 4;         % number of element nodes 
ndof = 2;         % degrees-of-freedom per node
neq  = nnp*ndof;  % number of equations


f = zeros(neq,1);      % initialize nodal force vector
d = zeros(neq,1);      % initialize nodal displacement vector
K = zeros(neq);        % initialize stiffness matrix

flags = zeros(neq,1);  % array to set B.C flags 
e_bc  = zeros(neq,1);  % essential B.C array
n_bc  = zeros(neq,1);  % natural B.C array
P     = zeros(neq,1);   % initialize point load defined at a node 
b     = zeros(neq,1);  % constant force defined over the nodes

ngp    = 2;             % number of gauss points in each direction

% essential BCs
nd   = 4;         % number of dofs on essential boundary

% node:    1x 1y 2x 2y 3x 3y 4x 4y 
flags   = [2  2  2  2  0  0  0  0 ]';     % 


% what to plot
compute_force  = 'yes';
plot_mesh      = 'yes';
plot_nod       = 'yes';
plot_disp      = 'yes';
plot_disp_contour = 'yes';
plot_force     = 'yes';


% natural BC - defined on edges positioned on natural boundary
n_bc  = [ 1              %  node 1 
          4              %  node 2   
          0              %  force at node 1
          -20            %  force at node 1
          0              %  force at node 2
          -20 ];         %  force at node 2
            
nbe = 1;   % number of edges on the natural boundary


% mesh generation
% node:  1    2    3    4
x   =  [0.0  0.0  2.0  2.0];     % X coordinate
y   =  [1.0  0.0  0.5  1.0];     % Y coordinate

IEN =  [1    2    3    4  ]';     % connectivity array


plotmesh;
