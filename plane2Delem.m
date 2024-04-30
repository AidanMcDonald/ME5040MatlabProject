function [ke, fe] = plane2Delem(e)
include_flags;

ke  = zeros(nen*ndof,nen*ndof);    % initialized element conductance matrix
fe  = zeros(nen*ndof,1);      % initialize element nodal source vector

% get coordinates of element nodes 
je = IEN(:,e);  
C  = [x(je); y(je)]'; 

[w,gp] = gauss(ngp);    % get gauss points and weights

% compute element conductance matrix and nodal flux vector 
for i=1:ngp
   for j=1:ngp
       eta = gp(i);            
       psi = gp(j);
 
       N             = NmatPlane2D(eta,psi);       % shape functions matrix  
       [B, detJ]     = BmatPlane2D(eta,psi,C);     % derivative of the shape functions

       ke = ke + w(i)*w(j)*B'*D*B*detJ;   % element conductance matrix
       be = N*b(:,e);                     % body force
       fe = fe + w(i)*w(j)*N'*be*detJ;    % element nodal source vector

   end       
end


