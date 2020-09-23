##### markdown記法でテーブルスキーマ（モデル名、カラム名、データ型）を記載する
## 株式会社万葉様新入社員教育課題
### テーブルについて
**User**
|データ型|カラム名|
|:---|:---|
|string|name|
|string|email|
|string|password_digest|


**Task**
|データ型|カラム名|
|:---|:---|
|string|name|
|text|content|
|date|limit|
|integer|priority|
|string|status|
|begint|user_id|

**Label**
|データ型|カラム名|
|:---|:---|
|begint|user_id|
|begint|task_id|

**Herokuへのデプロイ方法**
<br>
### Herokuへのデプロイ方法
全てターミナル上で行う
1. デプロイをするアプリのディレクトリに移動する。
1. `$ heroku login`
1. `$ rails assets:precompile RAILS_ENV=production`
<br>
アセットプリコンパイルを行う
1. `$ git add -A`
1. `$ git commit -m "コミットメッセージ"`
1. `$ heroku create`
<br>
heroku上にアプリを作成（初回のみ）
1. `$ heroku create`　heroku上にアプリを作成（初回のみ）
1. 必要であればheroku上にheroku buildpackを追加する<br>
  - `$ heroku buildpacks:set heroku/ruby`
  - `$ heroku buildpacks:add --index 1 heroku/nodejs`