% Metodo Simplex 

clc; clear all;

% Exemplo do Slide:
A = [1 2 2 1 0 0; 2 1 2 0 1 0; 2 2 1 0 0 1];
b = [20; 20; 20];
c = [-10; -12; -12; 0; 0; 0];
m = size(A,1);
n = size(A,2);

% PASSO 1 - Iniciando com uma base e uma solucao basica factivel
while (true)
    x = zeros(n,1);
    aux = randperm(n);
    base = sort(aux(1:m));
    B = A(:,base);    
    x(base) = inv(B)*b;
    
    if isempty(find(x == Inf,1)) && isempty(find(x < 0,1))
        break;
    else
    end
end

% PASSO 2 - Computando os custos reduzidos, se todos positivos
%           a solucao atual eh otima
while (true)
    custos_reduzidos = c' - c(base)' * inv(B) * A; %custo reduzido
    negativos = find(custos_reduzidos < 0);
    
    if(isempty(negativos))
        break; %solucao otima
    else
    end
    
    j = negativos(1);
    
    % PASSO 3 - Computando u, se todos negativos
    %           theta eh infinito, custo otimo -infinito
    u = inv(B) * A(:,j);
    positivos = find(u > 0);
    
    if(isempty(positivos))
        disp('Custo Otimo eh -infinito');
        break;
    else
    end
    
    % PASSO 4 - Computando theta, pois existe componente positiva em u
    theta = x(base(1)) / u(1);
    
    % PASSO 5 - Formando uma nova base
    L = 1;
    i = 1;    
    while (i <= m)
        if(theta < 0 || x(base(i))/u(i) < theta && u(i) > 0)
            theta = x(base(i))/u(i);
            L = i;        
        else i = i + 1;
        end
    end
    
    x(base) = x(base) - theta*u;
    base(L) = j;
    B = A(:,base);
    x(j) = theta;
end
disp('Solucao Otima: ');x
disp('Custo Otimo: ')
disp(c' * x)
