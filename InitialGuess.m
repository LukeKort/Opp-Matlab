%----------Matlab Code by L. Kort (Oct. 01, 2019)--------------------------
%----------Valores iniciais------------------------------------------------
global aux_pop nov a b aux_x0 aux_r 
aux_x0=zeros(nov,aux_pop);             %Pre-alocando espaço para velocidade
aux_r=zeros(nov,aux_pop);
for i=1:nov
    for j=1:aux_pop
        aux_x0(i,j)=a(1,i)+(b(1,i)-a(1,i))*rand();
        aux_r(i,j)=a(1,i)+(b(1,i)-a(1,i))*rand();
    end
end