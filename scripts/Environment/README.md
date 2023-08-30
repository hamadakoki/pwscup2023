PWSCUP2023　環境構築用スクリプト
==


## 前提
- dockerが実行できる
- docker composeが実行できる

## 手順
- 以下のコマンドを実行して、PWS Cup2023スクリプトの実行環境を作成する
```bash
$ docker compose up -d --build
```

- 実行環境にログインする
```bash
$ docker compose exec ruby bash
```

- 配布スクリプトが配置されているscriptsフォルダに移動する
```bash
$ cd pwscup2023/scripts
```



