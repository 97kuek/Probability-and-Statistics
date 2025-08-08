% exp_inverse_cdf_histogram.m
% 指数分布（lambda=2）の乱数を逆関数法で生成し，
% 20,000 個のサンプルを [0,0.1),[0.1,0.2),…,[9.9,10),[10,∞) に分類して
% ヒストグラムをプロットするスクリプト

clearvars; close all; clc;

%% 乱数シード（任意）
% シードを時間に応じて設定すると毎回異なる乱数列になります
rng('shuffle');

%% パラメータ設定
lambda = 2;           % 指数分布のパラメータ λ
N = 20000;            % サンプル数

%% 一様乱数の生成（0～1）
U = rand(N,1);

%% 逆関数法による指数乱数生成
% F^{-1}(u) = -1/λ * log(1-u)
X = - (1/lambda) * log(1 - U);

%% ビン（区間）の定義
% [0:0.1:10] までを等幅 0.1 で，最後に [10,∞) を追加
edges = [0:0.1:10, Inf];

%% ヒストグラムの計算
counts = histcounts(X, edges);

%% ビン中心の計算（プロット用）
% edges = [0,0.1,0.2,…,10,Inf] なので，
% ビン中心は 0.05,0.15,…,9.95 の長さ 100 のベクトル
binCenters = edges(1:end-2) + diff(edges(1:end-1))/2;
% 最後のビン中心だけ特別に設定（10 ～ ∞ の代表値として例えば 10.05）
binCenters(end+1) = 10.05;

%% ヒストグラムの描画
figure('Name','Exponential Random Samples Histogram','NumberTitle','off');
bar(binCenters, counts, 'hist');
xlim([0 11]);
xlabel('サンプル区間');
ylabel('発生数');
title('指数分布(\lambda=2)の逆関数法によるヒストグラム');
grid on;