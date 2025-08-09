function paths = save_to_results(probFolder, figHandle, pngFilename, tablePairs)
    % 引数(保存先フォルダ名、図バンドル、PNG名、表データ)チェック
    if nargin < 4
        error('save_to_results:NotEnoughInputs', ...
              '引数は (probFolder, figHandle, pngFilename, tablePairs) が必要です。');
    end

    % resultsフォルダがあるか確認
    resultsDir = fullfile(pwd, 'results');
    assert(exist(resultsDir,'dir')==7, ...
        '現在のフォルダ(%s)に "results" フォルダが見つかりません。先に作成してください。', pwd);

    % サブフォルダ準備
    probDir = fullfile(resultsDir, probFolder);
    if ~exist(probDir, 'dir')
        mkdir(probDir);
    end

    % 図保存
    pngPath = fullfile(probDir, pngFilename);
    try
        exportgraphics(figHandle, pngPath, 'Resolution', 300);
    catch
        saveas(figHandle, pngPath);
    end

    % CSV 保存
    if ~iscell(tablePairs) || size(tablePairs,2) ~= 2
        error('tablePairs は {filename, table} の N×2 セル配列にしてください。');
    end

    csvPaths = strings(size(tablePairs,1),1);
    for k = 1:size(tablePairs,1)
        fname = tablePairs{k,1};
        T     = tablePairs{k,2};
        if ~ischar(fname) && ~isstring(fname)
            error('tablePairs{%d,1} はファイル名文字列である必要があります。', k);
        end
        if ~istable(T)
            error('tablePairs{%d,2} は table 型である必要があります。', k);
        end
        fpath = fullfile(probDir, char(fname));
        writetable(T, fpath);
        csvPaths(k) = string(fpath);
    end

    if nargout > 0
        paths = struct('dir', probDir, 'png', pngPath, 'csv', csvPaths);
    end
end
