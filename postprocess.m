% plot temperature and flux
function postprocess(d)
include_flags

% Plot deformed mesh
if strcmpi(plot_disp,'yes')
    scaleFactor = 1e4;
    d1 = d(ID);
    j = 1;
    for i = 1:ndof:nnp*ndof
        deformedx(j) = x(j) + d1(i)*scaleFactor;
        deformedy(j) = y(j) + d1(i+1)*scaleFactor;
        j = j + 1;
    end
   
   figure(); 
   for e=1:nel
       XX = [x(IEN(1,e))  x(IEN(2,e))  x(IEN(3,e))  x(IEN(4,e))  x(IEN(1,e))];
       YY = [y(IEN(1,e))  y(IEN(2,e))  y(IEN(3,e))  y(IEN(4,e))  y(IEN(1,e))];
       plot(XX,YY,'g');
       hold on;
       XX = [deformedx(IEN(1,e))  deformedx(IEN(2,e))  deformedx(IEN(3,e))  deformedx(IEN(4,e))  deformedx(IEN(1,e))];
       YY = [deformedy(IEN(1,e))  deformedy(IEN(2,e))  deformedy(IEN(3,e))  deformedy(IEN(4,e))  deformedy(IEN(1,e))];
       plot(XX,YY,'r');  
   end
title('Deformed shape'); xlabel('X'); ylabel('Y');
legend('Undeformed shape', 'Deformed shape', 'Location','southeast')
end

% Displacement contour plots
if strcmpi(plot_disp_contour,'yes')
    figure();
    for e=1:nel
        XX = [x(IEN(1,e)) x(IEN(2,e)) x(IEN(3,e)) x(IEN(4,e)) x(IEN(1,e))];
        YY = [y(IEN(1,e)) y(IEN(2,e)) y(IEN(3,e)) y(IEN(4,e)) y(IEN(1,e))];
        d1 = d(ID);
        j = 1;
        for i = 1:ndof:nnp*ndof
            d2(j) = d1(i);
            j = j + 1;
        end
        dd = d2(IEN(:,e));
        dd(end+1)=dd(1);
        patch(XX,YY,dd);hold on;

    end
    title('U_x contours'); xlabel('X'); ylabel('Y'); colorbar


    figure();
    for e=1:nel
        XX = [x(IEN(1,e)) x(IEN(2,e)) x(IEN(3,e)) x(IEN(4,e)) x(IEN(1,e))];
        YY = [y(IEN(1,e)) y(IEN(2,e)) y(IEN(3,e)) y(IEN(4,e)) y(IEN(1,e))];
        
        d1 = d(ID);
        j = 1;
        for i = 1:ndof:nnp*ndof
            d2(j) = d1(i+1);
            j = j + 1;
        end
        dd = d2(IEN(:,e));
        dd(end+1)=dd(1);
        patch(XX,YY,dd);hold on;

    end
    title('U_y contours'); xlabel('X'); ylabel('Y'); colorbar
end

if strcmpi(print_stressStrain,'yes')
    fprintf(1,'\n                     Stress and Strain at Gauss Points \n')
    fprintf(1,'----------------------------------------------------------------------------- \n')
    for e=1:nel
    fprintf(1,'Element  %d \n',e)
    fprintf(1,'-------------\n')
    stressAndStrainAtIntPoints(d,e)
    end
end