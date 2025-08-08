% pareto_law_of_large_numbers_and_variance.m
% パレート分布(x0=1, a=2)で乱数を生成し，
% サンプル平均 X_n とサンプル分散 σ_n^2 を n=1…2000 でプロット

clearvars; close all; clc;

%% 乱数シード設定
rng('shuffle');

%% パラメータ
x0   = 1;      % スケールパラメータ
a    = 2;      % 形状パラメータ
Nmax = 2000;   % 最大サンプル数

%% パレート乱数生成（逆関数法）
U = rand(Nmax,1);
X = x0 * (1 - U).^(-1/a);

%% サンプル平均 X_n の計算
Xn = cumsum(X) ./ (1:Nmax)';

%% サンプル分散 σ_n^2 の計算
sigma2_n = cumsum((X - 2).^2) ./ (1:Nmax)';

%% プロット：サンプル平均とサンプル分散
figure('Name','大数の法則と分散の挙動','NumberTitle','off');

% サンプル平均
subplot(2,1,1);
plot(1:Nmax, Xn, 'LineWidth', 1.2);
hold on;
yline(2, 'r--','LineWidth',1.5);  % 理論期待値 2
hold off;
xlabel('n');
ylabel('X_n');
title('サンプル平均 X_n の収束');
grid on;

% サンプル分散
subplot(2,1,2);
plot(1:Nmax, sigma2_n, 'LineWidth', 1.2);
xlabel('n');
ylabel('\sigma_n^2');
title('サンプル分散 \sigma_n^2 の挙動');
grid on;
