% B matrix function
 
function [B_reshaped, detJ] = BmatPlane2D(eta,psi,C)
        
      % Calculate the Grad(N) matrix
        GN    = .25 *[eta-1  1-eta   1+eta   -eta-1;
                      psi-1  -psi-1  1+psi    1-psi];

        J     = GN*C;       % compute Jacobian matrix 
        detJ  = det(J);     % Jacobian
      
        B     = inv(J)*GN;       % compute the B matrix

        B_reshaped = [B(1,1) 0      B(1,2) 0      B(1,3) 0      B(1,4) 0     ;
                      0      B(2,1) 0      B(2,2) 0      B(2,3) 0      B(2,4);
                      B(2,1) B(1,1) B(2,2) B(1,2) B(2,3) B(1,3) B(2,4) B(1,4)];
        %-- J\GN means solve the solution of x for GN*x=J, equivalent to (GN)^{-1}*J
   
