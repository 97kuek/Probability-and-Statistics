% 問題1-4（save_to_results 利用版）

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
fig = figure('Name','大数の法則による標本平均の収束','NumberTitle','off');
plot(1:Nmax, Xn, 'LineWidth', 1.5); hold on;

% 真の期待値 (a*x0/(a-1) = 2)
yline(a*x0/(a-1), 'r--', 'LineWidth', 1.5); hold off;

xlabel('標本数n', 'FontSize',12);
ylabel('平均値','FontSize',12);
title('大数の法則による標本平均の収束','FontSize',14);

legend({'標本平均 X_n', '真の期待値 2'}, ...
       'Interpreter','tex','Location','best');
grid on;

%% CSV 用テーブル作成
% 1) サンプル生データ（U と X）
T_samples = table(U, X, 'VariableNames', {'U_uniform','X_pareto'});

% 2) 逐次平均の推移（n と Xn）
T_running = table((1:Nmax)', Xn, 'VariableNames', {'n','X_n'});

%% 保存（./results/prob1_4 に PNG と CSV を出力）
save_to_results('prob1_4', fig, '問題1-4.png', {
    '問題1-4サンプル生データ.csv', T_samples;
    '問題1-4逐次平均.csv',         T_running
});
