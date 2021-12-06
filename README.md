# ENGINEER-HOUSE  


## サイト概要

エラーに向き合うことが大切な「プログラミング」。当サイトでは、基礎的な構文などのお悩みから、専門性の高い内容まで、幅広く知識の共有が出来る。
プロジェクト機能では、自ら議題を立ち上げ、そこへ集まった仲間と共にディスカッションすることにより、問題の解決を図ることが出来る。また、質問
機能では、様々な方から回答をいただくことができ、多種多様な実装方法を身につけることが出来る。これらの施策を通じて、プログラミング学習に
より専念して頂きたいという強い思いのもと、制作した。


### サイトテーマ

プログラミングの質問・解決サイト


### テーマを選んだ理由

 グループ内での話し合いの場を設けることにより、プログラミング学習にお困りの方はヒントを得ることができ、
 教える側はアウトプットすることにより、理解を深めることが出来る。また、大衆へ向けて質問を投稿することで、
 多種多様な実装方法を身につけることが出来る。
 私自身、プログラミング学習を通して感じた一人で学習することの難しさを解消したいと強く感じた。
 これから学習をする方が同じような思いにならないよう、当サイトを開設しようと思い至った。


### ターゲットユーザー

- プログラミング学習にお困りの方
- 現役エンジニアでさらなる高みを目指したい方


### 主な利用シーン

- エラー・理解が難しいなど行き詰まりを感じた際に、グループで相談したり、質問を投稿することにより、解決へ近づく。
- 様々な記事を読むことにより、考えが深まり、プログラムへのアプローチ方法を学ぶことに役立つ。


### アピールポイント

- [ホーム画面のJavaScriptによるアニメーション]

　ユーザーが最初に目にするホーム画面全体に動的なアニメーションを付けることにより、  
　当サイトへ興味・関心を持ってもらえるように工夫した。
 
- [例外処理]

　POST・PATCH操作の際の画面読み込み時にエラーが発生しないよう、例外処理を施した。  
 （下記のお問い合わせ、会員のアプリケーション詳細設計書参照）
 
- [Google Natural Language API]

　お問い合わせ機能の送信メール（管理者側）へ感情分析結果を表示するように実装。  
 （参考資料として、ユーザー側への送信メールも添付している）
 
　[管理者]
 
　![admin-email](https://user-images.githubusercontent.com/89015721/144790095-eac84999-6eec-421a-963a-ce1a0df5f3d5.png)

　[ユーザー]
 
　![customer-email](https://user-images.githubusercontent.com/89015721/144790182-a558e1d1-9857-4939-9c81-8755d7615d63.png)


## 設計概要


### [ER図]

![ポートフォリオ-ER図](https://user-images.githubusercontent.com/89015721/141829548-a03810da-1868-43b5-8154-3cd62dfc6c9b.jpg)


### [アプリケーション詳細設計書]

![ポートフォリオ-ルーティング (2)](https://user-images.githubusercontent.com/89015721/142724414-65f11188-d563-4456-998f-c8dbc00c6897.jpg)


## 開発環境

- OS：Amazon Linux 2
- 言語：HTML,CSS,JavaScript,Ruby,SQL
- フレームワーク：Ruby on Rails,RSpec
- JS ライブラリ：jQuery
- IDE：AWS Cloud9


### [使用言語]
- HTML & CSS
- Javascript
- Ruby（2.6.3）
- Ruby on Rails（5.2.5）


### [使用Gem]

![ポートフォリオ-gem](https://user-images.githubusercontent.com/89015721/144173298-c515cbb0-11e3-4855-b995-1ef5a6d04e5e.jpg)


### [開発者]

taku8a
