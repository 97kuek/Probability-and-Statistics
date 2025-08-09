% 問題1-5

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

%% サンプル分散 σ_n^2 の計算（母平均 2 を用いた逐次平均）
sigma2_n = cumsum((X - 2).^2) ./ (1:Nmax)';

%% プロット：サンプル分散
fig = figure('Name','パレート分布における標本分散の推移','NumberTitle','off');
plot(1:Nmax, sigma2_n, 'LineWidth', 1.2);
xlabel('標本数n');
ylabel('標本分散');
title('パレート分布における標本分散の推移');
grid on;

%% CSV 用テーブル作成
% 1) サンプル生データ（U と X）
T_samples  = table(U, X, 'VariableNames', {'U_uniform','X_pareto'});
% 2) 分散系列（n と sigma2_n）
T_variance = table((1:Nmax)', sigma2_n, 'VariableNames', {'n','sigma2_n'});

%% 保存（./results/prob1_5 に PNG と CSV を出力）
save_to_results('prob1_5', fig, '問題1-5.png', {
    '問題1-5サンプル生データ.csv', T_samples;
    '問題1-5分散系列.csv',         T_variance
});
