%----------Matlab Code by L. Kort (Oct. 01, 2019)--------------------------
%----------Inicialização---------------------------------------------------
warning off;
%----------Variáveis Globais-----------------------------------------------
global aux_pop nov a b c LE LI tol id aux_x0 aux_r pop_reduction count noc aux_g
%--------------------------------------------------------------------------
x0=aux_x0;   %Geração de sementes externa
r=aux_r;
aux_LI=LI;
pop=aux_pop;
g=ones(pop,1)*max(aux_g);
tic;                           %Inicialização da contagem do tempo
for i=1:LE
%----------Avanço dos lobos------------------------------------------------
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
Delta=zeros(nov,pop);            %Pre-alocando espaço para velocidade
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
            dk = -inv(hs)*gk;                 %Método de Newton
            %lambda =armijo(x0(:,k)',dk',gk);  %Chamando a funcao armijo
            lambda=10e-3;                                  %Calculando o proximo x
	        %x(:,k) = x0(:,k) +(lambda*dk+(1-lambda)* Delta(:,k));
            x(:,k) = x0(:,k) +(lambda*dk+(0.9)* Delta(:,k));
%----------Comentários-----------------------------------------------------                           
% lambda tem como objetivo controlar a intensidade da variação do passo dk
% Delta tem como objetivo aumentar a velocidade de convergência do método e
% diminuir o perigo da instabilidade (por exemplo, o algoritmo começa a
% convergir para um ponto que pensa ser um mínimo global, mas na verdade
% está em um mínimo local. Ou ainda, ajuda a convergir para um mínimo
% global onde o gradiente não é o vetor nulo.
%----------Restrições do sistema (Não modificar!)--------------------------
            for w=1:nov
                if x(w,k)<a(1,w)
                    x(w,k)=a(1,w);
                end
                if x(w,k)>b(1,w)
                    x(w,k)=b(1,w);
                end
            end
            %----------Restrições------------------------------------------
            UCF(x(:,k));                       %Arquivos de restrições
            %--------------------------------------------------------------
            if count==noc
                if(UFF(x(:,k)) < UFF(x0(:,k)))     %Arquivos de funções
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
        break   %Critério de parada por tolerância (funciona?)
    end
    %----------Matar lobos-------------------------------------------------
    pop=round(pop*(1-pop_reduction));    %Aproximar para tirar casa decimal
    x0_temp=zeros(nov,pop);      %Alocando vetores temporários
    f=g;
    for j=1:pop
        [min_temp,h]=min(f);    %h é a posição de cada novo mínimo
        f(h)=max(f);            %Tirando o mínimo para não repetir seleção
        x0_temp(:,j)=x0(:,h);   %Colocando ponto onde ocorre o mínimo no x0
    end
    g=ones(pop,1);
    x0=ones(nov,pop);
    for j=1:pop
        g(j)=UFF(x0(:,j));
        x0(:,j)=x0_temp(:,j);
    end
    %----------------------------------------------------------------------
end