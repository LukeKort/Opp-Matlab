%----------Matlab Code by L. Kort (Set. 28, 2019)--------------------------
%Método originalmente criado por Rein Luus e T.H.I. Jaakola. Versão
%modificada.
global nov a b c LE LI tol aux_x0 count noc 
tic;
x0=aux_x0(:,1);   %Geração de sementes externa
x=zeros(nov,1);
r=1;
for i=1:LE
    aux_x=x0;
    for j=1:LI
       R=(rand()-0.5);
       x=x0+R*r;
        %----------Restrições do sistema (Não modificar!)------------------
        for w=1:nov               
            if x(w)<a(1,w)
                x(w)=a(1,w);
            end
            if x(w)>b(1,w)
                x(w)=b(1,w);
            end
        end
       %----------Restrições-----------------------------------------------
       UCF(x);                       %Arquivos de restrições
       %-------------------------------------------------------------------
       if count==noc
           if ((UFF(x)) < (UFF(x0)))
               x0=x;
           end
       end
    end
    r=(1-c)*abs(aux_x-x0);
    dif=max(max(abs(aux_x)-abs(x0)));
%     if (dif<tol)
%         break   %Critério de parada por tolerância
%     end
end
xalfa=x0;
fxalfa=UFF(xalfa);