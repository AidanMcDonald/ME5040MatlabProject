function stressAndStrainAtIntPoints(d,e)
include_flags;
de = d(LM(:,e));
je = IEN(:,e);
C = [x(je); y(je)]';
[w,gp] = gauss(ngp);

% compute strains and stress at gauss points
ind = 1;
for i=1:ngp
    for j=1:ngp
        eta = gp(i); psi = gp(j);
        N = NmatPlane2D(eta,psi);
        [B, detJ] = BmatPlane2D(eta,psi,C);
        Na = [N(1,1) N(1,3) N(1,5) N(1,7)];
        X(ind,:) = Na*C;
        epsilon(:,ind) = B*de;
        sigma(:,ind) = D*epsilon(:,ind);
        ind = ind + 1;
    end
end
e_xx = epsilon(1,:);
e_yy = epsilon(2,:);
e_xy = epsilon(3,:);
s_xx = sigma(1,:);
s_yy = sigma(2,:);
s_xy = sigma(3,:);

% Print x-coord y-coord sigma_xx sigma_yy sigma_xy
stress_gauss = [X(:,1) X(:,2) s_xx' s_yy' s_xy' ];
strain_gauss = [X(:,1) X(:,2) e_xx' e_yy' e_xy' ];
fprintf(1,'\tx-coord\t\t\ty-coord\t\t\tsigma_xx\t\tsigma_yy\t\tsigma_xy\n');
fprintf(1,'\t%f\t\t%f\t\t%f\t\t%f\t\t%f\n',stress_gauss');
fprintf(1,'\n');
fprintf(1,'\tx-coord\t\t\ty-coord\t\t\tepsilon_xx\t\tepsilon_yy\t\tepsilon_xy\n');
fprintf(1,'\t%f\t\t%f\t\t%f\t\t%f\t\t%f\n',strain_gauss');
