# News Crawler
## 概要
- クローラー  
日本取引所グループのサイトから東証銘柄一覧ファイル(xls)をダウンロードし、一覧に記載されている銘柄のニュースのリンクを日経新聞のサイトから収集する。
- api  
東証銘柄一覧をJSON形式で返す。銘柄ごとのニュースのリンク情報の一覧をJSON形式で返す。

## 準備
- bundle install
- nodejs nodejs-legacyをインストールする
- node_modules/.binのパスを通す

- rails db:create
- rails db:migrate

## 実行
- 東証銘柄一覧取得  
`rake crawl_stock_list:crawl`

- ニュースリンク収集  
`rake 'crawl_news:crawl[market,level]'`  
marketには次のいずれかを入れる  
  市場第一部（内国株）  
  市場第二部（内国株）  
  マザーズ（内国株）  
  JASDAQ(グロース・内国株）  
  JASDAQ(スタンダード・内国株）  
  PRO Market  
  
levelにはクローラが集める記事のページ数を入れる  

例えば次のコマンドではマザーズの銘柄それぞれに対してニュースのリンクを1ページ(20記事)集める  
`rake 'crawl_news:crawl[マザーズ（内国株）,1]'`

