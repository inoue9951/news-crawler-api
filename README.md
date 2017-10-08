# News Crawler
## 概要
- クローラー
  - 日本取引所グループのサイトから東証銘柄一覧ファイル(xls)をダウンロードし、一覧に記載されている銘柄のニュースのリンクを日経新聞のサイトから収集する。
- api
  - 東証銘柄一覧をJSON形式で返す。銘柄ごとのニュースのリンク情報の一覧をJSON形式で返す

## 準備
* bundle install
* nodejs nodejs-legacyをインストールする
* node_modules/.binのパスを通す

* rails db:create
* rails db:migrate

