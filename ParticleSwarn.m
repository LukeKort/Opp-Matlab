%----------Matlab Code by L. Kort (Oct. 01, 2019)--------------------------
%Método originalmente criado por James Kennedy e Russell Eberhart. Versão
%contém modificações.
%----------With code from M. Kort and A. Silva-----------------------------
global aux_pop nov a b LE LI tol aux_x0 count noc aux_g
m=0.7;              %Termo de momentum;
c1=2;               %coeficiente de aceleração;
c2=2;               %coeficiente de aceleração;
%Inicialização aleatória da posição e velocidade inicial das partículas;
x0=aux_x0; 
v=aux_x0;
pop=aux_pop;
x=zeros(nov,pop);
aux_LE=LE*LI;
xalfa=min(UFF(x0)); %primeiro xalfa
minparticle=aux_x0;
tic
g=aux_g;
for i=1:aux_LE 
    for j=1:pop
        v(:,j)= m*v(:,j) + rand()*c1*(minparticle(:,j)-x(:,j)) + rand()*c2*(xalfa - x(:,j));%Velocidade;
        x(:,j)=x0(:,j)+v(:,j);      %Posição;g
        for w=1:nov
            if x(w,j)<a(1,w)
                x(w,j)=a(1,w);
            end
            if x(w,j)>b(1,w)
                x(w,j)=b(1,w);
            end
        end
        %----------Restrições----------------------------------------------
        UCF(x(:,j));                %Arquivos de restrições
        %------------------------------------------------------------------
        if count==noc
            if UFF(x0(:,j)) > (UFF(x(:,j)))
                x0(:,j)=x(:,j);
                g(j)=(UFF(x0(:,j)));
                if UFF(minparticle(:,j)) > UFF(x(:,j))
                    minparticle(:,j)=x(:,j); %P1 (menor valor para a partícula)
                end
            end
        end
    end
    [fxalfa, h]=min(g);  %P2 do método (menor de toda a população)
    xalfa=x0(:,h);
    dif=max(max(abs(x0-x)));
    if (dif<tol)
        break   %Critério de parada por tolerância
    end
end