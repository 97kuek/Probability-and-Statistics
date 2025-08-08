clearvars; close all; clc;

%% 乱数シード設定
rng('shuffle');

%% パラメータ設定
lambda = 1.62;   % ポアソン分布のパラメータ λ
N      = 20000;  % サンプル数

%% 一様乱数生成
U = rand(N,1);   % (N×1) の一様乱数

%% 理論 PMF と CDF（x = 0:10）
maxX = 10;               % ビンの上限（10 以上は 10 とまとめる）
x     = (0:maxX)';       % 縦ベクトル
pmf   = exp(-lambda) .* lambda.^x ./ factorial(x);
cdf   = cumsum(pmf);     % CDF(0), CDF(1), …, CDF(10)

%% 逆関数法による離散乱数生成（ベクトル化）
X = sum( U > cdf.', 2 );
X( X > maxX ) = maxX;

%% 発生確率の計算
edges = -0.5:(maxX+0.5);        % ビン区切り：[-0.5,0.5),[0.5,1.5),…,[9.5,10.5)
counts = histcounts(X, edges);  % 各ビンのカウント
p_est  = counts / N;            % 実測確率

%% ヒストグラムのプロット
figure('Name','Poisson(\lambda=1.62) 乱数ヒストグラム','NumberTitle','off');
bar(x, p_est, 'hist');

xlabel('x','FontSize',12);
ylabel('確率','FontSize',12);
title('Poisson(\lambda=1.62) 乱数のヒストグラムと理論 PMF','FontSize',14);
legend('実測確率');
grid on;
