% Shape function 
 
function N = NmatPlane2D(eta,psi)
       
        N  = 0.25 * [(1-psi)*(1-eta) 0 (1+psi)*(1-eta) 0 (1+psi)*(1+eta) 0 (1-psi)*(1+eta) 0;
                     0 (1-psi)*(1-eta) 0 (1+psi)*(1-eta) 0 (1+psi)*(1+eta) 0 (1-psi)*(1+eta)]; % shape functions