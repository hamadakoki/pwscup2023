# PWS Cup 2023 コンテストシステム用ファイル

ここでは
[PWS Cup 2023](https://www.iwsec.org/pws/2023/cup23.html)のコンテストシステム関連のファイルを，参加者には直接関係のないファイルも含めて，コンテストの透明性を高めることを目的に公開しています．コンテストで参加者向けに公式に提供しているスクリプトは，./scripts/ 以下に含まれています．

以下は，コンテスト参加者には直接関係のない，参考情報です．自由に参考にしていただいて構いません．もし明らかな不具合がありましたらお知らせいただけると有り難いです．

## CodaLab でのコンテストシステム構築手順

### コンテスト bundle の作成
このディレクトリを起点に以下を実行し，CodaLab のコンテスト bundle (cup23-codalab-bundle-nodir-*.zip) を作成．
```
$ cd scripts
$ make
$ cd ..
$ make zip
```

### コンテスト bundle のアップロード後の作業
CodaLab の UI 上では設定できて，competition.yaml では設定できない設定項目があるため，いくつかの設定は bundle のアップロード後に手作業で行う必要がある．PWS Cup 2023 では，以下を手作業で設定した．
- Anonymous leaderboard にチェック
- Leaderboard の各項目の Show rank のチェックを外す
