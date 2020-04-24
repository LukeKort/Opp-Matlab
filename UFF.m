%----------Matlab Code by L. Kort (Aug. 19, 2019)--------------------------
%----------Universal Function File-----------------------------------------
%----------Inicialization--------------------------------------------------
function [y] = UFF(x)
%----------Exempo----------------------------------------------------------
% x1 = x(1);
% x2 = x(2);
% term1 = -(x2+47) * sin(sqrt(abs(x2+x1/2+47)));
% term2 = -x1 * sin(sqrt(abs(x1-(x2+47))));
% y = term1 + term2;
%----------Insira a função a ser otimizada abaixo--------------------------

x1 = x(1);
x2 = x(2);

fact1 = sin(x1)*sin(x2);
fact2 = exp(abs(100 - sqrt(x1^2+x2^2)/pi));

y = -0.0001 * (abs(fact1*fact2)+1)^0.1;

end