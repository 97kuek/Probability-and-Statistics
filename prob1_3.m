% pareto_inverse_cdf_histogram.m
% パレート分布（x0=1, a=2）の乱数を逆関数法で生成し，
% 20,000 個のサンプルを [1,2),[2,3),…,[9,10),[10,∞) に分類して
% ヒストグラムをプロットするスクリプト

clearvars; close all; clc;

%% 乱数シード設定（任意）
rng('shuffle');  % 毎回異なる乱数列に

%% パラメータ
x0 = 1;      % スケールパラメータ
a  = 2;      % 形状パラメータ
N  = 20000;  % サンプル数

%% 一様乱数生成
U = rand(N,1);        

%% 逆関数法によるパレート乱数生成
% CDF: F(x) = 1 - (x0/x)^a  =>  1 - U = (x0/x)^a  =>  x = x0 * (1 - U)^(-1/a)
X = x0 * (1 - U).^(-1/a);

%% ビン（区間）の定義
edges = [1:1:10, Inf];   % [1,2),[2,3),…,[9,10),[10,∞)

%% ヒストグラム集計
counts = histcounts(X, edges);

%% ビン中心の計算
% 有限幅ビン：中心 = 下端 + 幅/2
binCenters = edges(1:end-2) + diff(edges(1:end-1))/2;  
% 最後のビン中心（[10,∞) の代表として 11 とする）
binCenters(end+1) = 11;  

%% ヒストグラム描画
figure('Name','Pareto Distribution Histogram','NumberTitle','off');
bar(binCenters, counts, 'hist');
xlim([1 12]);
xlabel('サンプル区間');
ylabel('生成数');
title('Pareto(x₀=1, a=2) の逆関数法によるヒストグラム');
grid on;
