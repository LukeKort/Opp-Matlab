%----------Matlab Code by L. Kort (Set. 30, 2019)--------------------------
global MinVector TimeVector xalfaVector nov aux_g na aux_pop a b c LE LI tol id pop_reduction 
warning off;
clc;
fprintf('\t\t|OPP|\n')
%----------Sele��o dos M�todos---------------------------------------------
answerLJ=input('\nExecutar m�todo Luus Jaakola?[y/n]','s');
answerAL=input('Executar m�todo Alcateia?[y/n]','s');
answerAD=input('Executar m�todo Alcateia Determin�stico?[y/n]','s');
answerPSO=input('Executar m�todo Particle Swarn?[y/n]','s');
answerHB=input('Executar m�todo H�brido?[y/n]','s');
%----------Par�metros de input---------------------------------------------
na=0;       %N�mero de algoritmos executados
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
    fprintf('\nNenhum m�todo foi escolhido.\n');
    pause(3);
    Opp; 
end
answer=input('\nN�mero de execu��es? ');
%--------------------------------------------------------------------------
load('Parameters');               %Carregando par�metros
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
MinVector=zeros(answer,na);       %Pre-alocando espa�o para velocidade
TimeVector=zeros(answer,na);
xalfaVector=zeros(answer,nov*na);
name=cell(na,1);
Label=cell(1,na);
aux_g=ones(aux_pop,1);
clc;
fprintf('\t\t|OPTIMIZATION PLATAFORM|\n')
fprintf('\nExecu��es completas:0/%d - 0%%\n',answer);
for u = 1:answer
    na=0;
    InitialGuess;
    for i=1:aux_pop
        aux_g(i)=UFF(aux_x0(:,i));
    end
    aux_g=ones(aux_pop,1)*max(aux_g);
    %----------Chamada das fun��es-----------------------------------------
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
        name(na,1)={'Alcateia Determin�stico'};
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
        name(na)={'M�todo H�brido'};
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
    fprintf('\nExecu��es completas:%d/%d - %d%%\n',u,answer,round(100*u/answer));
end
for i=1:na   %Imprimir resultados na janela de comandos
    aux_name=string(name(i));
    fprintf('\n%d) %s',i,aux_name);
    fprintf('\nValor m�nimo: %d',min(MinVector(:,i)));
    fprintf('\nTempo m�dio de execu��o: %d\n',mean(TimeVector(:,i)));
end
%----------Gr�fico M�nimo vs Execu��o--------------------------------------
answer_g=input('\nRepresenta��o gr�fica global?[y/n]','s');
if answer_g=='y'    
    na=0;
    lim=linspace(1,answer,answer);   %Eixo x (Execu��o)
    if answerLJ == 'y'
        na=na+1;
        figure('Name','Luus-Jaakola')
        scatter(lim, MinVector(:,na),25,'filled')
        title('M�nimo por Execu��o: Luus-Jaakola');
        xlabel('Execu��o');
        ylabel('Valor do m�nimo');
    end
    if answerAL == 'y'
        na=na+1;
        figure('Name','Alcateia')
        scatter(lim, MinVector(:,na),25,'filled')
        title('M�nimo por Execu��o: Alcateia');
        xlabel('Execu��o');
        ylabel('Valor do m�nimo');
    end
    if answerAD == 'y'
        na=na+1;
        figure('Name','Alcateia Determin�tico')
        scatter(lim, MinVector(:,na),25,'filled')
        title('M�nimo por Execu��o: Alcateia Determin�tico');
        xlabel('Execu��o');
        ylabel('Valor do m�nimo');
    end
    if answerPSO == 'y'
        na=na+1;
        figure('Name','Particle Swarn')
        scatter(lim, MinVector(:,na),25,'filled')
        title('M�nimo por Execu��o: Particle Swarn');
        xlabel('Execu��o');
        ylabel('Valor do m�nimo');
    end
    if answerHB == 'y'
        na=na+1;
        figure('Name','M�todo H�brido')
        scatter(lim, MinVector(:,na),25,'filled')
        title('M�nimo por Execu��o: M�todo H�brido');
        xlabel('Execu��o');
        ylabel('Valor do m�nimo');
    end
end
Opp;