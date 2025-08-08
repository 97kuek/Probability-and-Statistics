% pareto_law_of_large_numbers_tex.m
% TeX インタープリターのみを使って日本語＋数式を表示

clearvars; close all; clc;

%% 乱数シード設定
rng('shuffle');

%% パラメータ
x0   = 1;
a    = 2;
Nmax = 2000;

%% パレート乱数生成
U = rand(Nmax,1);
X = x0 * (1 - U).^(-1/a);

%% サンプル平均の計算
Xn = cumsum(X) ./ (1:Nmax)';

%% プロット
figure('Name','大数の法則：パレート分布（TeX）','NumberTitle','off');
plot(1:Nmax, Xn, 'LineWidth', 1.5);
hold on;

% 真の期待値 (a*x0/(a-1) = 2)
h = yline(a*x0/(a-1), 'r--', 'LineWidth',1.5);

hold off;

xlabel('n', 'FontSize',12);                              % 横軸はただの数値
ylabel('X_n = 1/n \Sigma_{i=1}^{n} X_i', ...              % \Sigma で和記号
       'Interpreter','tex', 'FontSize',12);
title('パレート分布(x_0=1, a=2)による大数の法則の挙動', ...
      'Interpreter','tex','FontSize',14);

legend({'サンプル平均 $X_n$', '真の期待値 $2$'}, ...
       'Interpreter','tex','Location','best');
grid on;
