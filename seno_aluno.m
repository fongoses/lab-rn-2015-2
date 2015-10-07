%aproximação do seno a partir de instâncias ruidosas
clear all;
clc; close all;
x = -pi:pi/16:pi;
[ind xm]=size(x);
y = sin(x);
t = sin(x) + 0.1*randn(size(x)); %seno com 10% de ruído
plot(x,y);
hold on;
plot(x,t,'*b') ;
ni=1; %nr. de entradas
nh=1; %ajustar nr. de unidades ocultas
no=1; %nr. de unidades de saída
%algoritmo BP com saída linear - para regressão
%inicializaçao dos pesos
wo=1.0*(2*rand(nh, ni+1)-ones(nh,ni+1)); %ajustar a inicialização dos pesos
ws=1.0*(2*rand(no, nh+1)-ones(no,nh+1)) %ajustar a inicialização dos pesos
%laço
epocas=100; %ajustar o numero de epocas da simulaçao
epoca=1;
lrt=0.01; %ajustar a taxa de aprendizado
pats=xm; %numero de padroes do arquivo de treinamento
dwo=zeros(nh,ni+1);
dwop=dwo;
dws=zeros(no, nh+1);
dwsp=dws;
xx=[ones(1,xm); x];
while epoca < epocas+1
    for i=1:pats
        vo=xx(:,i)'*wo'; %potencial de ativação da cam. oculta
        ho=tanh(vo); %saída da cam. oculta, sem bias
        io=[1 ho]; %introduçao da entrada extra para o bias da saida
        vs=io*ws';
        yi=vs; %saída linear
        e(i)=t(i)-yi; %erro instantaneo
        gs=e(i); %gradiente local da unidade de saida
        dws=lrt*gs*io; %termo de ajuste dos pesos de saída
        ws=ws+dws;
        go=(ws(2:nh+1)*gs).*(1-io(2:nh+1).^2); %gradiente local da cam. oculta
        for j=1:nh
            dwo(j,:)=lrt*xx(:,j)'*go(j);
        end
        wo=wo+dwo;
    end
    eqm(epoca)=sum(e.^2)/xm; %erro quadratico medio da época
    epoca=epoca+1;
end
figure;
plot(eqm);
%propagaçao após treinamento
yp=zeros(1,xm);
for i=1:xm
        vo=xx(:,i)'*wo';
        ho=tanh(vo);
        io=[1 ho];
        vs=io*ws';    
        yp(i)=vs; %escreve valor obtido
end
    figure;
plot(x,y);
hold on;
plot(x,t,'*b') ; 
plot(x,yp,'or') ; 
EQM_final = eqm(epocas) %escreve erro quadratico médio final