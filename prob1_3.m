% 問題1-3

clearvars; close all; clc;

%% 乱数シード設定
rng('shuffle');

%% パラメータ
x0 = 1;      % スケールパラメータ
a  = 2;      % 形状パラメータ
N  = 20000;  % サンプル数

%% 一様乱数生成
U = rand(N,1);        

%% 逆関数法によるパレート乱数生成
X = x0 * (1 - U).^(-1/a);

%% ビン（区間）の定義
edges = [1:1:10, Inf];

%% ヒストグラム集計
counts = histcounts(X, edges);

%% ビン中心の計算
binCenters = edges(1:end-2) + diff(edges(1:end-1))/2;  
binCenters(end+1) = 11;

%% ヒストグラム描画
fig = figure('Name','パレート分布に従う乱数のヒストグラム','NumberTitle','off');
bar(binCenters, counts, 1);
xlim([1 12]);
xlabel('階級');
ylabel('度数(個数)');
title('パレート分布に従う乱数のヒストグラム');
grid on;

%% CSV 用テーブル作成
% 1) サンプル生データ（U と X）
T_samples = table(U, X, 'VariableNames', {'U_uniform','X_pareto'});

% 2) ヒストグラムデータ（各ビンの左端/右端/中心/カウント）
bin_left   = edges(1:end-1).';
bin_right  = edges(2:end).';
bin_center = binCenters(:);
count      = counts(:);
T_hist = table(bin_left, bin_right, bin_center, count, ...
    'VariableNames', {'bin_left','bin_right','bin_center','count'});

%% 保存（./results/prob1_3 に PNG と CSV を出力）
save_to_results('prob1_3', fig, '問題1-3.png', {
    '問題1-3サンプル生データ.csv',   T_samples;
    '問題1-3ヒストグラムデータ.csv', T_hist
});
