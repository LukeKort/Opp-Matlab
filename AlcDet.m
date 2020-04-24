%----------Matlab Code by L. Kort (Oct. 01, 2019)--------------------------
%----------Inicializa��o---------------------------------------------------
warning off;
%----------Vari�veis Globais-----------------------------------------------
global aux_pop nov a b c LE LI tol id aux_x0 aux_r pop_reduction count noc aux_g
%--------------------------------------------------------------------------
x0=aux_x0;   %Gera��o de sementes externa
r=aux_r;
aux_LI=LI;
pop=aux_pop;
g=ones(pop,1)*max(aux_g);
tic;                           %Inicializa��o da contagem do tempo
for i=1:LE
%----------Avan�o dos lobos------------------------------------------------
% figure(i);
% hold on;
% xlim ( [ -10 10 ] );
% ylim ( [ -10 10 ] );
% scatter(x0(1,:),x0(2,:),'filled');
% if i>1
%     scatter(xalfa(1),xalfa(2),'g','filled');
% end
%[lx0,cx0]=size(x0);
% f=ones(cx0,1)*100000000;
% fxalfa=100000000000000000000000000000;
Delta=zeros(nov,pop);            %Pre-alocando espa�o para velocidade
x=zeros(nov,pop);
% g=ones(pop,1)*max(aux_g);
    if aux_LI<1
        aux_LI=1;
    end
    aux_x=x0;
    %aux_f=fxalfa;
    for j = 1:aux_LI
        for k=1:pop
            Delta(:,k)=r(:,k);
            gk = gradiente(x0(:,k)');         %Chamando a funcao gradiente
            hs = hessi(x0(:,k)');             %Chamando a funcao hessiana
            dk = -inv(hs)*gk;                 %M�todo de Newton
            %lambda =armijo(x0(:,k)',dk',gk);  %Chamando a funcao armijo
            lambda=10e-3;                                  %Calculando o proximo x
	        %x(:,k) = x0(:,k) +(lambda*dk+(1-lambda)* Delta(:,k));
            x(:,k) = x0(:,k) +(lambda*dk+(0.9)* Delta(:,k));
%----------Coment�rios-----------------------------------------------------                           
% lambda tem como objetivo controlar a intensidade da varia��o do passo dk
% Delta tem como objetivo aumentar a velocidade de converg�ncia do m�todo e
% diminuir o perigo da instabilidade (por exemplo, o algoritmo come�a a
% convergir para um ponto que pensa ser um m�nimo global, mas na verdade
% est� em um m�nimo local. Ou ainda, ajuda a convergir para um m�nimo
% global onde o gradiente n�o � o vetor nulo.
%----------Restri��es do sistema (N�o modificar!)--------------------------
            for w=1:nov
                if x(w,k)<a(1,w)
                    x(w,k)=a(1,w);
                end
                if x(w,k)>b(1,w)
                    x(w,k)=b(1,w);
                end
            end
            %----------Restri��es------------------------------------------
            UCF(x(:,k));                       %Arquivos de restri��es
            %--------------------------------------------------------------
            if count==noc
                if(UFF(x(:,k)) < UFF(x0(:,k)))     %Arquivos de fun��es
                    x0(:,k)=x(:,k);
                    g(k)= (UFF(x(:,k)));
                end
                g(k)= (UFF(x0(:,k)));
            end
        end
    end
        
    [fxalfa, h]=min(g);
    xalfa=x0(:,h);
    aux_LI=aux_LI*(1-c);
    for k=1:pop
        %x0(:,k)=(id*x0(:,k)+(1-id)*xalfa);
        x0(:,k)=(id(k)*x0(:,k)+(1-id(k))*xalfa);
        r(:,k)=((x0(:,k)-aux_x(:,k)));
    end
    x0;
    Delta;
    dif=max(max(r));
    if (dif<tol)
        break   %Crit�rio de parada por toler�ncia (funciona?)
    end
    %----------Matar lobos-------------------------------------------------
    pop=round(pop*(1-pop_reduction));    %Aproximar para tirar casa decimal
    x0_temp=zeros(nov,pop);      %Alocando vetores tempor�rios
    f=g;
    for j=1:pop
        [min_temp,h]=min(f);    %h � a posi��o de cada novo m�nimo
        f(h)=max(f);            %Tirando o m�nimo para n�o repetir sele��o
        x0_temp(:,j)=x0(:,h);   %Colocando ponto onde ocorre o m�nimo no x0
    end
    g=ones(pop,1);
    x0=ones(nov,pop);
    for j=1:pop
        g(j)=UFF(x0(:,j));
        x0(:,j)=x0_temp(:,j);
    end
    %----------------------------------------------------------------------
end