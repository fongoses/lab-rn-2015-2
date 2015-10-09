%solu�ao simples do xor por BP - algoritmo das transparencias
%MLP: 2 neuronios ocultos e 1 neuronios de saida
clear;
clc;
close all;
% entradas da tabela verdade bipolar com entrada extra xo = +1
x=[1 -1 -1; 1 -1 1; 1 1 -1; 1 1 1];
d=[-1; 1; 1; -1]; %valores desejados da fun�ao
%inicializa�ao dos pesos
wo=1.0*(2*rand(2, 3)-ones(2,3)); %ajustar a inicializa��o dos pesos
ws=0.5*(2*rand(1, 3)-ones(1,3)); %encontrando o multiplicador adequado
%la�o
epocas=100; %ajustar o numero de epocas da simula�ao
epoca=1;
lrt=0.25; %ajustar a taxa de aprendizado
pats=4; %numero de padroes do arquivo de treinamento
dwo=zeros(2,3);
while epoca < epocas+1
    for i=1:pats
        vo=x(i,:)*wo'; %potencial de ativa��o da cam. oculta
        ho=tanh(vo); %sa�da da cam. oculta, sem bias
        io=[1 ho]; %introdu�ao da entrada extra para o bias da saida
        vs=io*ws';
        y=tanh(vs);
        e(i)=d(i)-y; %erro instantaneo
        gs=e(i)*(1-y^2); %gradiente local da unidade de saida
        dws=lrt*gs*io; %termo de ajuste dos pesos de sa�da
        ws=ws+dws; %ajuste dos pesos de sa�da
        go=(ws(2:3)*gs).*(1-io(2:3).^2); %gradiente local da cam. oculta
        dwo(1,:)=lrt*x(i,:)*go(1); % termo de ajuste dos pesos da unidade oculta 1
        dwo(2,:)=lrt*x(i,:)*go(2); % termo de ajuste dos pesos da unidade oculta 2
        wo=wo+dwo; %ajuste dos pesos da camada oculta
    end
    eqm(epoca)=sum(e.^2)/4; %erro quadratico medio da �poca
    epoca=epoca+1;
end
%propaga�ao ap�s treinamento
for i=1:4
        vo=x(i,:)*wo';
        ho=tanh(vo);
        io=[1 ho];
        vs=io*ws';
        desejado = d(i) %escreve valor desejado
        y=tanh(vs) %escreve valor obtido
    end
plot(eqm);
EQM_final = eqm(epocas) %escreve erro quadratico m�dio final


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RESULTADOS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%desejado = -1
%y = -0.9149

%desejado = 1
%y = 0.9397

%desejado = 1
%y = 0.9377

%desejado = -1
%y = -0.9191

%EQM_final = 0.0055

%O problema e que ao ser executado v�rias vezes com os mesmos parametros
%o resultado pode piorar
