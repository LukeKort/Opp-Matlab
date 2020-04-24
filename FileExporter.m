%----------Matlab Code by L. Kort (Aug. 30, 2019)--------------------------
%----------File Exporter---------------------------------------------------
global MinVector TimeVector xalfaVector
warning off;
%----------Exportar resultados para Excel----------------------------------
Label_nov=cell(1,na*nov+(1-nov));
for i=1:na
    Label_nov(1,i*nov+(1-nov))=Label(1,i); %Label para várias colunas
end
answer=input('\nNome do arquivo de saída: ','s');
xlswrite(answer,Label,'Mínimos');
xlswrite(answer,MinVector,'Mínimos','A2');
xlswrite(answer,Label_nov,'Posição do mínimo');
xlswrite(answer,xalfaVector,'Posição do mínimo','A2');
xlswrite(answer,Label,'Tempos');
xlswrite(answer,TimeVector,'Tempos','A2');
xlswrite(answer,{'População';'Variáveis';'Lim. Inf';'Lim. Sup';'Contração';'Laço Ext.';'Laço Int';'Tolerância';'Independência';'Redução da população'},'Parâmetros');
xlswrite(answer,ParametersVector,'Parâmetros','B1');
fprintf('\nArquivo salvo!\n');
pause(2);
Opp;
