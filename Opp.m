%----------Matlab Code by L. Kort (Oct. 02, 2019)--------------------------
%----------Inicializa��o---------------------------------------------------
clc
pause ('on');
%----------Par�metros iniciais---------------------------------------------
fprintf('\t\t|OPTIMIZATION PLATAFORM|\n')
fprintf('\nEditar par�mentros \t\t\t\t\t(1)\n')
fprintf('\nExecutar m�todos \t\t\t\t\t(2)\n')
fprintf('\nExportar resultados\t\t\t\t\t(3)\n')
fprintf('\nPlotar gr�fico \t\t\t\t\t\t(4)\n')
fprintf('\nCarregar dados da �ltima execu��o\t(5)\n')
fprintf('\nEncerrar programa \t\t\t\t\t(6)\n')
answer=input('\nOp��o:');
switch answer
    case 1
        Parameters;
    case 2
        %----------Processamento-------------------------------------------
        Processor;
    case 3
        %----------Exportar resultadoss------------------------------------
        FileExporter;

    case 4
        %----------Plotar Gr�ficos-----------------------------------------
        Plotter;
    case 5
        load('Backup');
        load('Label');
        load('Parameters');
        Opp;
    case 6
        answer=input('\nNova execu��o[y/n]?','s');
        if answer=='y'
            clc;
            Opp;
        else
            fprintf('\nCode by L. Kort (Oct. 02, 2019)')
            pause(3);
            exit;
            %return;
        end
end