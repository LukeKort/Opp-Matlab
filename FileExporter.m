%----------Matlab Code by L. Kort (Aug. 30, 2019)--------------------------
%----------File Exporter---------------------------------------------------
global MinVector TimeVector xalfaVector
warning off;
%----------Exportar resultados para Excel----------------------------------
Label_nov=cell(1,na*nov+(1-nov));
for i=1:na
    Label_nov(1,i*nov+(1-nov))=Label(1,i); %Label para v�rias colunas
end
answer=input('\nNome do arquivo de sa�da: ','s');
xlswrite(answer,Label,'M�nimos');
xlswrite(answer,MinVector,'M�nimos','A2');
xlswrite(answer,Label_nov,'Posi��o do m�nimo');
xlswrite(answer,xalfaVector,'Posi��o do m�nimo','A2');
xlswrite(answer,Label,'Tempos');
xlswrite(answer,TimeVector,'Tempos','A2');
xlswrite(answer,{'Popula��o';'Vari�veis';'Lim. Inf';'Lim. Sup';'Contra��o';'La�o Ext.';'La�o Int';'Toler�ncia';'Independ�ncia';'Redu��o da popula��o'},'Par�metros');
xlswrite(answer,ParametersVector,'Par�metros','B1');
fprintf('\nArquivo salvo!\n');
pause(2);
Opp;
