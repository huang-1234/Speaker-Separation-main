# DPRNN
基於[Dual-path-RNN-Pytorch](https://github.com/JusperLee/Dual-Path-RNN-Pytorch)

## 資料準備
資料夾目錄如：
```
.
├── mix
│   └── utt_id.wav
├── s1
│   └── utt_id.wav
└── s2
    └── utt_id.wav
```
s1和s2分別放不同speaker的音檔，mix放疊加後的音檔。同一筆training sample在三個資料夾中的檔名要一致。

李弘毅老師上課提供的資料集：[link](https://drive.google.com/file/d/1g3ObZnCNtdYMLYe-YNwbjkMlUrFszjxY/view)

## 訓練流程
1. 產生訓練用的scp檔
```
  python create_scp.py
```
需要手動修改資料集所在目錄。

2. 設定config檔

可以參考config/Dual_RNN/train_rnn.yml調整模型架構與訓練參數。

3. 訓練模型
```
  python train_rnn.py --opt config/Dual_RNN/train.yml
```

## Inference
- 對於單一音檔的inference可以透過
```
  bash sep_one.sh wav_path
```
或是
```
  python dualrnn_test_wav.py -mix_scp $file -yaml config/Dual_RNN/train_rnn.yml -model checkpoint/Dual_Path_RNN/best.pt -save_path demo_output
```

- 對於完整測試集的inference
```
  python dualrnn_test.py -mix_scp tt_mix.scp -yaml config/Dual_RNN/train_rnn.yml -model checkpoint/Dual_Path_RNN/best.pt -save_path output
```


## Evaluation
```
  python src/evaluate.py subset data_dir sample_rate
```
範例：
```
  python src/evaluate.py tt ./result/dual-rnn/ 8000
```
- subset為訓練、驗證、測試集（tr, cv, tt）
- data_dir為inference完成的音檔所在資料夾（dualrnn_test.py的save_path）
- sample_rate為模型訓練時採用的sample rate

## 實驗結果
針對李弘毅老師上課提供的資料集，分別實驗Conv-Tasnet ([link](https://github.com/JusperLee/Dual-Path-RNN-Pytorch))和Dual Path RNN的效果。DPRNN的model在checkpoint資料夾中。

|     Method    | SI-SNRi |
|:-------------:|:-------:|
|  Conv-Tasnet  |  10.41  |
| Dual Path RNN |  12.06  |
