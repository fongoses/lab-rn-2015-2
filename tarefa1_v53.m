%tarefa1
clear all; clc; close all;

h = 0.1;
x = -3:h:3;

y1 = tansig(x);
dy1 = dtansig(x,y1);
y2 = hardlims(x);
plot(x, y1, 'b', x, dy1, 'r', x, y2, 'g');
grid on;
display(sprintf('dtansig = %d\n', dtansig(3.0, tansig(3.0))));

y3 = logsig(x);
dy3 = dlogsig(x,y3);
y4 = hardlim(x);
figure;
plot(x, y3, 'b', x, dy3, 'r', x, y4, 'g');
grid on;
display(sprintf('dlogsig = %d\n', dlogsig(3.0, logsig(3.0))));


y1 = tanh(x);
dy1 = diff(y1) / h;
display(sprintf('dtanh = %d\n', dy1(end)));

u = sym('u');
g = tanh(u);
dg = diff(g);
dgv = subs(dg, u, x);
display(sprintf('dtanh calculated = %d\n', subs(dg, u, 3.0)));

y2 = hardlims(x);

figure;
plot(x, y1, 'b', x, [dy1 dy1(end)], 'r', x, y2, 'g', x, dgv, 'k');
grid on;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RESULTADOS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%dtansig = 9.866037e-003
%dlogsig = 4.517666e-002
%dtanh = 1.091586e-002
%dtanh calculated = 9.866037e-003
