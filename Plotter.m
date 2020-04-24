%----------Matlab Code by L. Kort (Set. 27, 2019)--------------------------
%----------With code from M. Kort------------------------------------------
%----------Plotter---------------------------------------------------------
warning ('off')
global noc count
if nov<=3
    %----------Gr�ficos 2d---------------------------------------------
    if nov==1
        x1=linspace(b,a,100);
        x=zeros(100,1);             
        fgrafico=zeros(100);
        for i=1:100
            x=x1(i);
            fgrafico(i)= (UFF(x));
            UCF(x);
            if count == noc
                fgrafico(i)= (UFF(x));
            else
                fgrafico(i)= nan;
            end
        end
        plot(x1,fgrafico)
        xlabel('x');
        ylabel('y');
    %----------Gr�ficos 3d---------------------------------------------
    else
        x1=linspace(b(1,1),a(1,1),100);
        x2=linspace(b(1,2),a(1,2),100);
        x=zeros(100);             
        fgrafico=zeros(100);
        for i=1:100
            for j=1:100
                x=[x1(i) x2(j)];
                UCF(x);
                if count == noc
                    fgrafico(i,j)= (UFF(x));
                else
                    fgrafico(i,j)= nan;
                end
            end
        end
        figure('Name','Gr�fico da fun��o')
        surfc(x1,x2,fgrafico)
        xlabel('x');
        ylabel('y');
        zlabel('z');
        %----------Salvando gr�fico------------------------------------
        answer=input('\nSalvar gr�fico?[y/n]' ,'s');
        if answer=='y'
            answer=input('\nNome do arquivo de sa�da: ','s');
            savefig(answer);
            fprintf('File Saved');
        end
    end
end
Opp;