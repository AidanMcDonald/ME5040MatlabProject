% Compute and assemble nodal boundary flux vector and point sources 

function f = loads(f)
include_flags;

% Assemble point sources 
f(ID) = f(ID) + P(ID);


% Compute nodal pressure vector
for i = 1:nbe
    
        ft      = [0 0 0 0]';            % initialize the nodal source vector
        node1   = n_bc(1,i);         % first node
        node2   = n_bc(2,i);         % second node
        n_bce   = n_bc(3:6,i);       % flux value at an edge
        
        
        x1 = x(node1); y1=y(node1);    % coord of the first node
        x2 = x(node2); y2=y(node2);    % coord of the second node
    
        leng = sqrt((x2-x1)^2 + (y2-y1)^2);  % edge length
        J    = leng/2;                       % 1D Jacobian 
    
        
        [w,gp] = gauss(ngp);                % get gauss points and weights
       
        for i=1:ngp                         % integrate in psi direction (1D integration)  
               
            psi = gp(i);               
            N   = 0.5*[1-psi 0 1+psi 0;0 1-psi 0 1+psi];       % 1D  shape functions in parent domain
            
            traction = N * n_bce;
            ft      = ft + w(i)*N' *traction*J;      % nodal traction
        end
        
        % Assemble nodal flux vector
        node1ind1 = ndof*(node1-1)+1; % index of first dof for node 1
        node1ind2 = node1ind1+1; % index of second dof for node 1
        node2ind1 = ndof*(node2-1)+1; % index of first dof for node 1
        node2ind2 = node2ind1+1; % index of second dof for node 2
        
        f(ID(node1ind1)) = f(ID(node1ind1)) + ft(1) ;
        f(ID(node1ind2)) = f(ID(node1ind2)) + ft(2) ;
        f(ID(node2ind1)) = f(ID(node2ind1)) + ft(3) ;
        f(ID(node2ind2)) = f(ID(node2ind2)) + ft(4) ;
end
