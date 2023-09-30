# アプリケーション名
にゃんログ

# アプリケーション概要
猫の体調管理アプリ。  
猫のご飯、トイレ掃除のタイミング、排泄物、体重などを写真で共有して管理することで、複数人で世話をしている場合でも毎日の猫の健康状態や世話のタイミングなどを把握できる。

# URL
https://nyanlog.onrender.com

# テスト用アカウント
・Basic認証ID：nekodesu  
・Basic認証ID：2222  
アカウント1  
・メールアドレス：aaa@aaa  
・パスワード：aaaaaa  
アカウント2  
・メールアドレス：bbb@bbb  
・パスワード：bbbbbb  
アカウント3  
・メールアドレス：ccc@ccc  
・パスワード：cccccc  

# 利用方法  
## チャット投稿機能
1.ユーザーの新規登録またはログインを行う  
2.「チャットを作成する」ボタンから、チャット名（猫の名前など）を入力、メンバーを選択し追加して新規チャットルームを作成  
3.チャットのカテゴリーを選択してテキストや画像を添付して投稿  
## カテゴリー検索機能
チャットルームを開き、チャットルーム名の右にあるセレクトボックスからカテゴリーを選択して🔍ボタンを押すと、そのカテゴリーの投稿のみが表示される。  
また、「全て」を選択するとすべてのカテゴリーの投稿が表示される。

# アプリケーションを作成した背景
現在3人で猫の世話をしているが、誰がいつ世話をしたか、下痢していないかなど、お互い確認しないと把握できず、不便に思っていた。  
また、病院に連れて行った際に排泄物の写真を見せることがあるが、カメラロールを毎回遡って写真を探すのも大変な上、カメラロールに大量の排泄物の写真があるのもなんとなく嫌だと思っていた。  
同様の問題を抱える人も多いと考え、これを解決するために、世話をした時に都度写真を撮って共有し、カテゴリーごとに写真を分けて表示できる機能がついたチャットアプリを開発することにした。

# 洗い出した要件
https://docs.google.com/spreadsheets/d/1wFhU2WeoMUDiP6p67OB_yW-sgrNzEcMmIWWezHZSA2E/edit?usp=sharing

# 実装した機能
## ユーザー管理機能
ログインページ  
[![Image from Gyazo](https://i.gyazo.com/a22106cd2ce2b31e9030911d911c2803.png)](https://gyazo.com/a22106cd2ce2b31e9030911d911c2803)  
新規登録ページ  
[![Image from Gyazo](https://i.gyazo.com/37fa9801b082a23157370d0aaf33449c.png)](https://gyazo.com/37fa9801b082a23157370d0aaf33449c)  

## チャットルーム作成機能
チャットルーム新規作成  
[![Image from Gyazo](https://i.gyazo.com/f114698c634123596c2ca83c14b686fe.png)](https://gyazo.com/f114698c634123596c2ca83c14b686fe)  
作成したチャットルーム  
[![Image from Gyazo](https://i.gyazo.com/44fb18435b651287bdcc71ff9ffe36a1.png)](https://gyazo.com/44fb18435b651287bdcc71ff9ffe36a1)  
## メッセージ投稿機能
画像とメッセージをつけて投稿できる  
[![Image from Gyazo](https://i.gyazo.com/38a2bad979184d6ca38c836f8d904ec9.jpg)](https://gyazo.com/38a2bad979184d6ca38c836f8d904ec9)  
カテゴリーごとに分けて表示できる  
[![Image from Gyazo](https://i.gyazo.com/db6d2c252fc15287f9daebce81ab0afe.gif)](https://gyazo.com/db6d2c252fc15287f9daebce81ab0afe)  

# 実装予定の機能
・レスポンシブ対応  
・ユーザー検索機能（チットルーム作成・編集時）  
・チャットルーム編集機能  
・チャットルームプロフィール機能  
・メッセージ編集機能  
・メッセージ削除機能  
・メッセージ画像プレビュー機能  

# 開発環境
・フロントエンド  
・バックエンド  
・インフラ  
・テスト  
・テキストエディタ  
・タスク管理  

# ローカルでの動作方法
以下のコマンドを順に実行
% git clone https://github.com/kotomiyashita/nyanlog  
% cd nyanlog  
% bundle install  
% rails db:create  
% rails db:migrate  

# 工夫したポイント
チャットルーム作成時のメンバー追加機能や、画像投稿の際のエラーメッセージ表示などにjavascriptを使用したが、  
その際のjsのコードは全てChatGPTに指示を出して書かせるなど、ChatGPTを有効活用して機能を実装できた。

# 改善点
未実装の機能（編集・削除機能など）を実装することにより利便性を高める必要がある。  
投稿されたメッセージを非同期通信で下に追加していくようにすることと、チャットルームを開いた際に一番上（古いメッセージ）が表示され、スクロールしないと新しいメッセージが見れないため、デフォルトで最新のメッセージが表示されるように設定する必要がある。  
また、エラーメッセージを表示することでなぜ送信できないかを分かりやすくする必要がある。
アプリの性質上ネイティブアプリにしたほうがより利便性は高まると考えている。  

また、これは自分一人でできる部分ではないが、IoTなどと連携することができればより良いと思う。  
例えば自動給餌器と連携してご飯を出した時間と量が自動で投稿されたり、  
猫のトイレを検知して排泄物の撮影やおしっこの量を検知したりして投稿されるなどができれば、  
猫の飼い主にとってより便利で使う価値のあるものになると思う。

# 制作時間
30時間程度

# テーブル設計

[![Image from Gyazo](https://i.gyazo.com/98267dd4577c1b559a7e69ae61c99acf.png)](https://gyazo.com/98267dd4577c1b559a7e69ae61c99acf)

## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| name               | string | null: false |
| email              | string | null: false |
| encrypted_password | string | null: false |

### Association

- has_many :room_users
- has_many :rooms, through: :room_users
- has_many :messages

## rooms テーブル

| Column | Type   | Options     |
| ------ | ------ | ----------- |
| name   | string | null: false |

### Association

- has_many :room_users
- has_many :users, through: :room_users
- has_many :messages

## room_users テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| room   | references | null: false, foreign_key: true |

### Association

- belongs_to :room
- belongs_to :user

## messages テーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| content     | string     |                                |
| user        | references | null: false, foreign_key: true |
| room        | references | null: false, foreign_key: true |
| category_id | integer    | null: false                    |

### Association

- belongs_to :room
- belongs_to :user
