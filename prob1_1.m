% 問題1-1・1-2
clearvars; close all; clc;

%% 乱数シード
rng('shuffle');

%% パラメータ設定
lambda = 2;           % 指数分布のパラメータ λ
N = 20000;            % サンプル数

%% 一様乱数の生成（0～1）
U = rand(N,1);

%% 逆関数法による指数乱数生成  X ~ Exp(lambda)
X = - (1/lambda) * log(1 - U);

%% ビン（区間）の定義：0～10を幅0.1、最後に [10, ∞)
edges = [0:0.1:10, Inf];

%% ヒストグラムの計算
counts = histcounts(X, edges);

%% ビン中心（プロット用）
binCenters = edges(1:end-2) + diff(edges(1:end-1))/2;
binCenters(end+1) = 10.05;

%% 図の描画
fig = figure('Name','指数分布に従う乱数のヒストグラム','NumberTitle','off');
bar(binCenters, counts, 1);
xlim([0 11]);
xlabel('階級');
ylabel('度数(個数)');
title('指数分布に従う乱数のヒストグラム');
grid on;

%% CSV 用テーブル作成
% 1) サンプル生データ（U と X）
T_samples = table(U, X, 'VariableNames', {'U_uniform','X_exponential'});

% 2) ヒストグラムデータ（各ビンの左端/右端/中心/カウント）
bin_left   = edges(1:end-1).';
bin_right  = edges(2:end).';
bin_center = binCenters(:);
count      = counts(:);
T_hist = table(bin_left, bin_right, bin_center, count, ...
    'VariableNames', {'bin_left','bin_right','bin_center','count'});

%% 保存（./results/prob1_1 に PNG と CSV を出力）
save_to_results('prob1_1', fig, '問題1-2.png', {
    '問題1-1,2サンプル生データ.csv', T_samples;
    '問題1-1,2ヒストグラムデータ.csv', T_hist
});
