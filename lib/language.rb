require 'base64' #エンコード / デコードを行うメソッドを定義したモジュールを提供するライブラリ(エンコード:データを他の形式へ変換すること, デコード:エンコードされたデータを元の形式に戻すこと)
#お問い合わせフォームに入力した内容をjson形式に変換し、APIを叩いて、返ってきたデータをjson形式からRubyオブジェクトに変換している。
require 'json' #jsonを扱うためのライブラリ
require 'net/https' #net/http に SSL/TLS 拡張を実装するライブラリ,Net::HTTP を再オープンし、SSL/TLS 拡張を追加します

module Language
  class << self
    def get_data(text)
      # APIのURL作成
      api_url = "https://language.googleapis.com/v1beta1/documents:analyzeSentiment?key=#{ENV['GOOGLE_API_KEY']}"
      # APIリクエスト用のJSONパラメータ
      params = {
        document: {
          type: 'PLAIN_TEXT',
          content: text
        }
      }.to_json
      # Google Cloud Natural Language APIにリクエスト
      uri = URI.parse(api_url)
      #<URI::HTTPS https://language.googleapis.com/v1beta1/documents:analyzeSentiment?key=AIzaSyCxS7pYLjAZEzTtWu8v-CC7WZT9YhKWIT0>➡URIオブジェクトを生成
      # parseしておくことにより、uri.host,uri.portが使える（parse == 解析する）
      https = Net::HTTP.new(uri.host, uri.port) #uri.host == language.googleapis.com(ホストのドメイン), uri.port == 443(httpsのポート番号),この２つを引数として渡すことにより、Net::HTTPオブジェクトを生成
      # Net::HTTP == HTTP のクライアントのためのクラス
      # HTTP で SSL/TLS を使うかどうかを設定します。
      # HTTPS 使う場合は true を設定します。 セッションを開始する前に設定をしなければなりません。
      # デフォルトでは false です。 つまり SSL/TLS を有効にするには必ず use_ssl = true を呼ぶ必要があります。通信するためには開かなければならない。
      https.use_ssl = true #この記述により、https通信が可能になる
      request = Net::HTTP::Post.new(uri.request_uri) #uri.request_uri == "/v1beta1/documents:analyzeSentiment?key=AIzaSyCxS7pYLjAZEzTtWu8v-CC7WZT9YhKWIT0",Net::HTTP::Post == HTTP の POST リクエストを表すクラスです
      # Content-Type == 実際にどんな形式のデータを送信したのかを表す(ここでは、application/json)
      # HTTPリクエストのPostメソッドのヘッダーのContent-Type
      request['Content-Type'] = 'application/json'
      # response == Net::HTTPOK 200 OK readbody=true(レスポンス成功　HTTPボディの内容が正しい)
      # requestメソッドでリクエストをサーバーに送信。引数にはrequest == Net::HTTP::Post POST, params == "{\"document\":{\"type\":\"PLAIN_TEXT\",\"content\":\"aadsfd\"}}"
      # 返ってきた値をresponseへ格納
      response = https.request(request, params)
      # APIレスポンス出力
      # 上記HTTPリクエストのpostに対するHTTPレスポンス
      # response.body(返ってきたデータ（json形式）のボディを取得している)
      response_body = JSON.parse(response.body)#JSON.parse(response.body)(引数のjson形式であるの文字列response.bodyをRubyオブジェクトに変換して返す)
      # response_body['error']があれば、格納されている['message']を表示。なければ、response_body['documentSentiment']['score']を返す。
      # コントローラーからメソッドを呼び出して、APIを叩いて、返ってきた値をインスタンス変数に格納している
      if (error = response_body['error']).present?
        raise error['message']
      else
        response_body['documentSentiment']['score']
      end
    end
  end
end