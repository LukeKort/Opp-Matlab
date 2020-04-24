%----------Matlab Code by L. Kort (Set. 28, 2019)--------------------------
%----------Parameters------------------------------------------------------
%global ParametersVector aux_pop nov a b c LE LI tol id pop_reduction
format short;
clc;
fprintf('\n|Parâmentros|\n')
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
fprintf('\nTamanho da população:\t\t%d',aux_pop);      
fprintf('\nNúmero de variáveis independentes:\t\t%d',nov);
fprintf('\nLimite inferior:\t\t\t%d',a); 
fprintf('\nLimite superior:\t\t\t%d',b);    
fprintf('\nNúmero de laços externos:\t%d',LE); 
fprintf('\nNúmero de laços internos:\t%d',LI);
fprintf('\nÍndice de tolerância:\t\t%d',tol);
fprintf('\nCoeficiente de contração:\t%d%%',c*100);   
%fprintf('\nÍndice de independândia:\t%d%%',id*100);
fprintf('\nRedução da população:\t\t%d%%',pop_reduction*100);
answer=input('\n\nNova configuração de parâmetros [y/n]?','s');
if answer=='y'
    aux_pop=input('\nTamanho da população:');      
    nov=input('Número de variáveis:');
    a=zeros(1,nov);
    b=zeros(1,nov);
    for i=1:nov
        fprintf('x%d\n',i)
        a(1,i)=input('Limite inferior:'); 
        b(1,i)=input('Limite superior:');    
    end 
    LE=input('Número de laços externos:'); 
    LI=input('Número de laços internos:');
    tol=input('Índice de tolerância:');
    c=input('Coeficiente de contração[%]:');
    c=c/100;
    %id=input('Índice de independândia:[%]:');
    for i=1:aux_pop
        id(i)=0.3+(0.6*rand());
    end
    %id=id/100;
    pop_reduction=input('Redução da população:[%]:');
    pop_reduction=pop_reduction/100;
    ParametersVector={aux_pop; nov; a; b; c; LE; LI; tol; id; pop_reduction};
    save('Parameters','ParametersVector');
else
    Opp;
end
Opp;