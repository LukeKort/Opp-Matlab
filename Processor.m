%----------Matlab Code by L. Kort (Set. 30, 2019)--------------------------
global MinVector TimeVector xalfaVector nov aux_g na aux_pop a b c LE LI tol id pop_reduction 
warning off;
clc;
fprintf('\t\t|OPP|\n')
%----------Seleção dos Métodos---------------------------------------------
answerLJ=input('\nExecutar método Luus Jaakola?[y/n]','s');
answerAL=input('Executar método Alcateia?[y/n]','s');
answerAD=input('Executar método Alcateia Determinístico?[y/n]','s');
answerPSO=input('Executar método Particle Swarn?[y/n]','s');
answerHB=input('Executar método Híbrido?[y/n]','s');
%----------Parâmetros de input---------------------------------------------
na=0;       %Número de algoritmos executados
if answerLJ == 'y'
    na=na+1;
end
if answerAL == 'y'
    na=na+1;
end
if answerAD == 'y'
    na=na+1;
end
if answerPSO == 'y'
    na=na+1;
end
if answerHB == 'y'
    na=na+1;
end
if na==0
    fprintf('\nNenhum método foi escolhido.\n');
    pause(3);
    Opp; 
end
answer=input('\nNúmero de execuções? ');
%--------------------------------------------------------------------------
load('Parameters');               %Carregando parâmetros
aux_pop=ParametersVector{1};      
nov=ParametersVector{2};       
a=ParametersVector{3};        
b=ParametersVector{4};       
c=ParametersVector{5};       
LE=ParametersVector{6};  
LI=ParametersVector{7}; 
tol=ParametersVector{8}; 
id=ParametersVector{9}; 
pop_reduction=ParametersVector{10};
%--------------------------------------------------------------------------
MinVector=zeros(answer,na);       %Pre-alocando espaço para velocidade
TimeVector=zeros(answer,na);
xalfaVector=zeros(answer,nov*na);
name=cell(na,1);
Label=cell(1,na);
aux_g=ones(aux_pop,1);
clc;
fprintf('\t\t|OPTIMIZATION PLATAFORM|\n')
fprintf('\nExecuções completas:0/%d - 0%%\n',answer);
for u = 1:answer
    na=0;
    InitialGuess;
    for i=1:aux_pop
        aux_g(i)=UFF(aux_x0(:,i));
    end
    aux_g=ones(aux_pop,1)*max(aux_g);
    %----------Chamada das funções-----------------------------------------
    if answerLJ=='y'
        na=na+1;
        LuusJaakola;
        name(na,1)={'Luus Jaakola'}; %Nome em cada sheet do xls
        Label(1,na)=name(na,1);      %Nome em cada coluna do xls
        MinVector(u,na)=fxalfa;
        TimeVector(u,na)=toc;
        for u1=1:nov
            xalfaVector(u,(nov*(na-1)+u1))=xalfa(u1);
        end
    end
    if answerAL=='y'
        na=na+1;
        Alcateia;
        name(na,1)={'Alcateia'};
        Label(1,na)=name(na,1);
        MinVector(u,na)=fxalfa;
        TimeVector(u,na)=toc;
        for u1=1:nov
            xalfaVector(u,(nov*(na-1)+u1))=xalfa(u1);
        end
    end
    if answerAD=='y'
        na=na+1;
        AlcDet;
        name(na,1)={'Alcateia Determinístico'};
        Label(1,na)=name(na,1);
        MinVector(u,na)=fxalfa;
        TimeVector(u,na)=toc;
        for u1=1:nov
            xalfaVector(u,(nov*(na-1)+u1))=xalfa(u1);
        end
    end
    if answerPSO=='y'
        na=na+1;
        ParticleSwarn;
        name(na)={'Particle Swarn'};
        Label(1,na)=name(na,1);
        MinVector(u,na)=fxalfa;
        TimeVector(u,na)=toc;
        for u1=1:nov
            xalfaVector(u,(nov*(na-1)+u1))=xalfa(u1);
        end
    end
    if answerHB=='y'
        na=na+1;
        Metodo_Hibrido;
        name(na)={'Método Híbrido'};
        Label(1,na)=name(na,1);
        MinVector(u,na)=fxalfa;
        TimeVector(u,na)=toc;
        for u1=1:nov
            xalfaVector(u,(nov*(na-1)+u1))=xalfa(u1);
        end
    end
    if u ==1
        save('Label','Label');
    end
    save('Backup','MinVector','TimeVector','na','xalfaVector','nov');
%     save('MinVector','MinVector'); %Backup para acidente
%     save('TimeVector','TimeVector');
%     save('xalfaVector','xalfaVector');
    clc;
    fprintf('\t\t|OPTIMIZATION PLATAFORM|\n')
    fprintf('\nExecuções completas:%d/%d - %d%%\n',u,answer,round(100*u/answer));
end
for i=1:na   %Imprimir resultados na janela de comandos
    aux_name=string(name(i));
    fprintf('\n%d) %s',i,aux_name);
    fprintf('\nValor mínimo: %d',min(MinVector(:,i)));
    fprintf('\nTempo médio de execução: %d\n',mean(TimeVector(:,i)));
end
%----------Gráfico Mínimo vs Execução--------------------------------------
answer_g=input('\nRepresentação gráfica global?[y/n]','s');
if answer_g=='y'    
    na=0;
    lim=linspace(1,answer,answer);   %Eixo x (Execução)
    if answerLJ == 'y'
        na=na+1;
        figure('Name','Luus-Jaakola')
        scatter(lim, MinVector(:,na),25,'filled')
        title('Mínimo por Execução: Luus-Jaakola');
        xlabel('Execução');
        ylabel('Valor do mínimo');
    end
    if answerAL == 'y'
        na=na+1;
        figure('Name','Alcateia')
        scatter(lim, MinVector(:,na),25,'filled')
        title('Mínimo por Execução: Alcateia');
        xlabel('Execução');
        ylabel('Valor do mínimo');
    end
    if answerAD == 'y'
        na=na+1;
        figure('Name','Alcateia Determinítico')
        scatter(lim, MinVector(:,na),25,'filled')
        title('Mínimo por Execução: Alcateia Determinítico');
        xlabel('Execução');
        ylabel('Valor do mínimo');
    end
    if answerPSO == 'y'
        na=na+1;
        figure('Name','Particle Swarn')
        scatter(lim, MinVector(:,na),25,'filled')
        title('Mínimo por Execução: Particle Swarn');
        xlabel('Execução');
        ylabel('Valor do mínimo');
    end
    if answerHB == 'y'
        na=na+1;
        figure('Name','Método Híbrido')
        scatter(lim, MinVector(:,na),25,'filled')
        title('Mínimo por Execução: Método Híbrido');
        xlabel('Execução');
        ylabel('Valor do mínimo');
    end
end
Opp;