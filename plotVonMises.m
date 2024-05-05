function plotVonMises(d)
include_flags;
% For von mises stress, we need stresses at nodes, not gauss points
nodeSigmas = zeros(nnp, 3);
for e=1:nel
    de = d(LM(:,e));
    je = IEN(:,e);
    C = [x(je); y(je)]';
    ind = 1;
        for eta=-1:2:1
            for psi=-1:2:1
                 N = NmatPlane2D(eta,psi);
                [B, detJ] = BmatPlane2D(eta,psi,C);
                Na = [N(1,1) N(1,3) N(1,5) N(1,7)];
                X(ind,:) = Na*C;
                epsilon(:,ind) = B*de;
                sigma(:,ind) = D*epsilon(:,ind);
                ind = ind + 1;
            end
        end
    nodeSigmas(je,:) = sigma';
end

% Plot them
figure();
    for e=1:nel
        XX = [x(IEN(1,e)) x(IEN(2,e)) x(IEN(3,e)) x(IEN(4,e)) x(IEN(1,e))];
        YY = [y(IEN(1,e)) y(IEN(2,e)) y(IEN(3,e)) y(IEN(4,e)) y(IEN(1,e))];
        
        je = IEN(:,e);
        elementNodeSigmas = nodeSigmas(je,:);
        s_xx = elementNodeSigmas(:,1);
        s_yy = elementNodeSigmas(:,2);
        s_xy = elementNodeSigmas(:,3);
        vonMises = (s_xx.^2-s_xx.*s_yy+s_yy.^2+3*s_xy.^2).^.5;
        
        dd = vonMises;
        dd(end+1)=dd(1);
        patch(XX,YY,dd);hold on;
    end
title('Von Mises stress contour'); xlabel('X'); ylabel('Y'); colorbar
end