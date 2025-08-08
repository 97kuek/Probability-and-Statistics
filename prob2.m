% normal_clt_histogram_nobox.m
% normcdf を使わずに CLT 法で N(2,7) 乱数ヒストグラムと理論確率をプロット

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
edges = -5:0.5:9;      % [-5, -4.5), ..., [8.5,9)
edges = [edges, Inf];  % 最後に [9,∞)

%% ヒストグラム集計（発生確率）
counts = histcounts(X, edges);
probs  = counts / N;

%% ビン中心の計算
binCenters = edges(1:end-2) + diff(edges(1:end-1))/2;
binCenters(end+1) = edges(end-1) + 0.25;  % [9,∞) の代表値

%% 理論的区間確率を erf で計算
% Φ(x; mu, sigma) = 0.5*(1 + erf((x-mu)/(sigma*sqrt(2))))
F = @(x) 0.5*(1 + erf((x - mu)/(sigma*sqrt(2))));
theoretical_p = diff( F(edges) );

%% 描画
figure('Name','CLTによるN(2,7)ヒストグラム (toolbox不要)','NumberTitle','off');
bar(binCenters, probs, 'hist');
hold on;
plot(binCenters, theoretical_p, 'r-', 'LineWidth', 1.5);
hold off;

xlim([-5 9]);
xlabel('x の区間');
ylabel('発生確率');
title('中心極限定理法による N(2,7) 乱数ヒストグラム');
legend({'実測確率','理論確率'}, 'Location','northeast');
grid on;
