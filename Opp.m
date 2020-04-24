%----------Matlab Code by L. Kort (Oct. 02, 2019)--------------------------
%----------Inicialização---------------------------------------------------
clc
pause ('on');
%----------Parâmetros iniciais---------------------------------------------
fprintf('\t\t|OPTIMIZATION PLATAFORM|\n')
fprintf('\nEditar parâmentros \t\t\t\t\t(1)\n')
fprintf('\nExecutar métodos \t\t\t\t\t(2)\n')
fprintf('\nExportar resultados\t\t\t\t\t(3)\n')
fprintf('\nPlotar gráfico \t\t\t\t\t\t(4)\n')
fprintf('\nCarregar dados da última execução\t(5)\n')
fprintf('\nEncerrar programa \t\t\t\t\t(6)\n')
answer=input('\nOpção:');
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
        %----------Plotar Gráficos-----------------------------------------
        Plotter;
    case 5
        load('Backup');
        load('Label');
        load('Parameters');
        Opp;
    case 6
        answer=input('\nNova execução[y/n]?','s');
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