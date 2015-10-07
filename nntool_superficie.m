%Aprende a superficie de transferencia de um controlador fuzzy por bkp
%utiliza funções do nntoolbox
clear;
close all; clc;
%arquivo com pontos da função a ser aprendida
fid=fopen('superficie.txt', 'r');
[xv, yv, zv] = textread('superficie.txt', '%7.4f %7.4f %7.4f');
[p ii]=size(xv);
n=sqrt(p);
%transforma os vetores de dados (xv, yv, zv) em matrizes (x, y, v)
for i=1:n
    for j=1:n
        x(i,j)=xv(n*(i-1)+j);
        y(i,j)=yv(n*(i-1)+j);
        z(i,j)=zv(n*(i-1)+j);
    end
end
surf(x,y,z);
grid on;
%prepara entradas e saidas desejadas para a rede
ent=[xv yv];
d=zv;
%cria rede mlp
net= newff([-180 180; -180 180], [1 1], {'tansig','purelin'},'trainlm');
net.trainParam.epochs = 100;
a = sim(net, ent');
net=train(net, ent', d');
out=sim(net, ent');
%transforma o vetor de saida da rede (out) em matriz (zout)
for i=1:n
    for j=1:n
        zout(i,j)=out(n*(i-1)+j);
    end
end
figure;
surf(x,y,zout);
