% 問題3

clearvars; close all; clc;

%% 乱数シード設定
rng('shuffle');

%% パラメータ設定
lambda = 1.62;   % ポアソン分布のパラメータ λ
N      = 20000;  % サンプル数

%% 一様乱数生成
U = rand(N,1);

%% 理論 CDF（x = 0:10）をサンプリング生成のみに使用
maxX = 10;                 % 10 以上は 10 にまとめる
x    = (0:maxX)';          % 0..10 の縦ベクトル
pmf  = exp(-lambda) .* lambda.^x ./ factorial(x);
cdf  = cumsum(pmf);        % CDF(0),...,CDF(10)

%% 逆関数法による離散乱数生成（ベクトル化）
X = sum( U > cdf.', 2 );   % 0..11 の整数（11 は 10超の分）
X( X > maxX ) = maxX;      % 10 以上は 10 に丸める

%% 実測確率の計算
edges  = -0.5:(maxX+0.5);  % [-0.5,0.5),...,[9.5,10.5)
counts = histcounts(X, edges);
p_est  = counts / N;

%% プロット（実測確率のみ）
fig = figure('Name','ポアソン分布に従う乱数ヒストグラム','NumberTitle','off');
bar(x, p_est, 1);
xlabel('階級','FontSize',12);
ylabel('度数(個数)','FontSize',12);
title('ポアソン分布に従う乱数のヒストグラム','FontSize',14);
grid on;

%% CSV 用テーブル作成
% 1) サンプル生データ（U と X）
T_samples = table(U, X, 'VariableNames', {'U_uniform','X_poisson_trunc10'});

% 2) ヒストグラムデータ（x, 発生数, 実測確率）
T_hist = table(x, counts(:), p_est(:), ...
    'VariableNames', {'x','count','p_observed'});

%% 保存（./results/prob3 に PNG と CSV を出力）
save_to_results('prob3', fig, '問題3.png', {
    '問題3サンプル生データ.csv',   T_samples;
    '問題3ヒストグラムデータ.csv', T_hist
});
