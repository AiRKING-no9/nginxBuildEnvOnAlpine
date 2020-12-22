# nginxBuildEnvOnAlpine
alpineベースのlaravel動作環境を構築  
作成されるlaravelProjectディレクトリは別リポジトリで管理を想定

## HOW TO USE
詳細はMakefileを参考  
※ makeコマンドの実行可能環境を想定  
makeが実行できない場合は `brew install make` かMakefileをみて順次実行する

### 初回起動
``` bash
make build
```
### 起動
``` bash
make start
```
### 停止

``` bash
maek stop
```
### ステータス確認
``` bash
make status
```
### コンテナ内に入る
``` bash
make in
```

## 今後のTODO
- [ ] DBコンテナの追加。laravelとの連携を追加
