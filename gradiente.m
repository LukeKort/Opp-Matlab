
function [gradiente]=gradiente(x)
	[L,C]=size(x);
    delta=0.00000000001;
    for i=1:C
  		k=x;
        k(i)=x(i)+delta;
   		s(i)=((UFF(k)-UFF(x))/delta);
    end
gradiente=s';