%tarefa1
clear all; clc; close all;

x=-3:0.1:3;

y1=tansig(x);
dy1=dtansig(x,y1);
y2=hardlims(x);
plot(x,y1,'b',x,dy1,'r',x,y2,'g');
grid on;
display(sprintf('dlogsig = %d\n', dtansig(3.0, tansig(3.0))));

y3=logsig(x);
dy3=dlogsig(x,y3);
y4=hardlim(x);
figure;
plot(x,y3,'b',x,dy3,'r',x,y4,'g');
grid on;
display(sprintf('dlogsig = %d\n', dlogsig(3.0, logsig(3.0))));

y1=tanh(x);
syms u;
g(u) = diff(tanh(u), u);
dy1 = eval(g(x));
y2 = hardlims(x);
figure;
plot(x,y1,'b',x,dy1,'r',x,y2,'g');
grid on;
display(sprintf('dtanh = %d\n', eval(g(3.0))));
