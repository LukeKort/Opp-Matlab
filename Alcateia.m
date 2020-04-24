%----------Matlab Code by L. Kort (Oct. 01, 2019)--------------------------
%Método criado por Cleber e Rosilene Corrêa. Versão
%contém modificações.
%----------Variáveis Globais-----------------------------------------------
global aux_pop nov a b c LE LI tol id aux_x0 aux_r noc count aux_g
%--------------------------------------------------------------------------
tic;                           %Inicialização da contagem do tempo
x0=aux_x0;                     %Geração de sementes externa
r=aux_r;                       %Geração de sementes externa
pop=aux_pop;
[lx0,cx0]=size(x0);
xalfa=zeros(nov,1);
f=ones(cx0,1)*100000000;
Delta=zeros(nov,pop);           %Pre-alocando espaço para velocidade
x=zeros(nov,pop);
aux_LI=LI;
g=aux_g;
for i=1:LE
    Delta=zeros(nov,pop);            %Pre-alocando espaço para velocidade
    x=zeros(nov,pop);
    aux_x=x0;
    for j=1:aux_LI
        for k=1:pop
            Delta(:,k)=(-1 +2*rand(nov,1)).*r(:,k);
            x(:,k)=x0(:,k)+Delta(:,k);
            %----------Restrições do sistema (Não modificar!)--------------
            for w=1:nov
                if x(w,k)<a(1,w)
                    x(w,k)=a(1,w);
                end
                if x(w,k)>b(1,w)
                    x(w,k)=b(1,w);
                end
            end
            %----------Restrições------------------------------------------
            UCF(x(:,k));                           %Arquivos de restrições
            %--------------------------------------------------------------
            if count==noc
                if(UFF(x(:,k)) < UFF(x0(:,k)))     %Arquivos de funções
                    x0(:,k)=x(:,k);
                    g(k)=(UFF(x0(:,k)));
                end
            end
         end
    end
    [fxalfa, h]=min(g);
    xalfa=x0(:,h);
    aux_LI=aux_LI*(1-c);
    for k=1:pop
        %x0(:,k)=(id*x0(:,k)+(1-id)*xalfa); Antiga ferramenta de independência
        x0(:,k)=(id(k)*x0(:,k)+(1-id(k))*xalfa); %Nova ferramenta de independência
        r(:,k)=abs(x0(:,k)-aux_x(:,k));
    end
    dif=max(max(r));
    if (dif<tol)
        break   %Critério de parada por tolerância
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