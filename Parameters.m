%----------Matlab Code by L. Kort (Set. 28, 2019)--------------------------
%----------Parameters------------------------------------------------------
%global ParametersVector aux_pop nov a b c LE LI tol id pop_reduction
format short;
clc;
fprintf('\n|Par�mentros|\n')
load('Parameters');
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
fprintf('\nTamanho da popula��o:\t\t%d',aux_pop);      
fprintf('\nN�mero de vari�veis independentes:\t\t%d',nov);
fprintf('\nLimite inferior:\t\t\t%d',a); 
fprintf('\nLimite superior:\t\t\t%d',b);    
fprintf('\nN�mero de la�os externos:\t%d',LE); 
fprintf('\nN�mero de la�os internos:\t%d',LI);
fprintf('\n�ndice de toler�ncia:\t\t%d',tol);
fprintf('\nCoeficiente de contra��o:\t%d%%',c*100);   
%fprintf('\n�ndice de independ�ndia:\t%d%%',id*100);
fprintf('\nRedu��o da popula��o:\t\t%d%%',pop_reduction*100);
answer=input('\n\nNova configura��o de par�metros [y/n]?','s');
if answer=='y'
    aux_pop=input('\nTamanho da popula��o:');      
    nov=input('N�mero de vari�veis:');
    a=zeros(1,nov);
    b=zeros(1,nov);
    for i=1:nov
        fprintf('x%d\n',i)
        a(1,i)=input('Limite inferior:'); 
        b(1,i)=input('Limite superior:');    
    end 
    LE=input('N�mero de la�os externos:'); 
    LI=input('N�mero de la�os internos:');
    tol=input('�ndice de toler�ncia:');
    c=input('Coeficiente de contra��o[%]:');
    c=c/100;
    %id=input('�ndice de independ�ndia:[%]:');
    for i=1:aux_pop
        id(i)=0.3+(0.6*rand());
    end
    %id=id/100;
    pop_reduction=input('Redu��o da popula��o:[%]:');
    pop_reduction=pop_reduction/100;
    ParametersVector={aux_pop; nov; a; b; c; LE; LI; tol; id; pop_reduction};
    save('Parameters','ParametersVector');
else
    Opp;
end
Opp;