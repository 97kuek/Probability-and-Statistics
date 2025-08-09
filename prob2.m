% 問題2

clearvars; close all; clc;

%% 乱数シード
rng('shuffle');

%% パラメータ設定
N      = 20000;       % サンプル数
mu     = 2;           % 期待値
sigma  = sqrt(7);     % 標準偏差
m      = 12;          % 一様乱数を足す個数（CLT の項数）

%% CLT 法による正規乱数生成
U = rand(N, m);
Z = ( sum(U,2) - m/2 ) / sqrt(m/12);
X = mu + sigma * Z;

%% ビン（区間）の定義
edges = -5:0.5:9;
edges = [edges, Inf];

%% ヒストグラム集計（発生確率）
counts = histcounts(X, edges);
probs  = counts / N;

%% ビン中心の計算
binCenters = edges(1:end-2) + diff(edges(1:end-1))/2;
binCenters(end+1) = edges(end-1) + 0.25;  % [9,∞) 代表値

%% 描画（実測確率のみ）
fig = figure('Name','CLTによるN(2,7)ヒストグラム','NumberTitle','off');
bar(binCenters, probs, 1);

xlim([-5 9]);
xlabel('階級');
ylabel('度数(個数)');
title('N(2,7)に従う乱数のヒストグラム（CLT法）');
grid on;

%% CSV 用テーブル作成
% 1) サンプル生データ（U, Z, X）
T_samples = table(U, Z, X, ...
    'VariableNames', {'U_uniform_mx', 'Z_standard_normal', 'X_normal'});

% 2) ヒストグラムデータ（各ビンの左端/右端/中心/発生数/実測確率）
bin_left   = edges(1:end-1).';
bin_right  = edges(2:end).';
bin_center = binCenters(:);
count      = counts(:);
p_obs      = probs(:);
T_hist = table(bin_left, bin_right, bin_center, count, p_obs, ...
    'VariableNames', {'bin_left','bin_right','bin_center','count','p_observed'});

%% 保存（./results/prob2 に PNG と CSV を出力）
save_to_results('prob2', fig, '問題2.png', {
    '問題2サンプル生データ.csv',   T_samples;
    '問題2ヒストグラムデータ.csv', T_hist
});
