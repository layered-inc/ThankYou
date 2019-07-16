# ThankYouCard Web Service [![Build Status](https://travis-ci.org/media-cf/ThankYou.svg?branch=master)](https://travis-ci.org/media-cf/ThankYou)

## メンバー同士で感謝の気持ちを伝え合うThankyou Card制度　WEB化してみました
メンバー同士で感謝の気持ちを伝え合うサンキューカード／サンクスカードの仕組み
（参考：　https://matome.naver.jp/odai/2146456539043542601　）
普段はなかなか口にしない感謝の気持ちをお互いに伝えあうことで、お互いに尊重し合える関係性を目指す仕組みとして、非常に優れた仕組みです。
でも、直接カードに書いて渡したり、張り出したりするのは、少し恥ずかしさもあるし、管理者も面倒なもの。また、手間が多いと制度自体も陳腐化してしまいます。
そこで、サンキューカードの仕組みを、簡単にWEBサービスとして利用できるようにしました。
グループチャットとしてSlackを使っていれば、Slackでログインして利用可能です。拠点が離れていても問題なく使えますし、集計や張り出しなどの面倒な作業も必要ありません。
カードの登録や閲覧はスマホからでも可能です。
Media Contents Factoryの社内利用として、開発しましたが、どうせなら他社でも使ってもらえればとオープンに公開していますので、ご自由にお使いくださいませ。
不明点等あればこちら (mcf@media-cf.co.jp )　まで。

導入や開発の経緯など、ブログにも書いてます。こちらもどうぞ。
http://www.mcf.bz/2018/02/28/post-2065/

## Screenshots
### メッセージ一覧
誰から、誰へ、メッセージカード内容と、非常にシンプルな作りです。全員のカードを見ることが出来ます。検索も可能です。
![image](https://user-images.githubusercontent.com/30608925/36360898-209ff9c2-156b-11e8-9fe7-170329857f15.png)

### Slackでのログイン機能
Slackでログイン可能です。Slackアカウントがない場合、メールアドレスでも可能です。
![image](https://user-images.githubusercontent.com/30608925/36358944-3dcdd6a2-1559-11e8-80d8-1fc468fbca06.png)

### メッセージ登録機能
全員が一度アカウントを作成すると、メッセージを相手に向けて新規作成可能です。
![image](https://user-images.githubusercontent.com/30608925/36358959-877f3c50-1559-11e8-813c-5bb8014bc599.png)


## Sign in with Slack

https://api.slack.com/docs/sign-in-with-slack

## Built with
ThankYou Rails is built with following libraries.

- Ruby 2.6
- Ruby on Rails 6
- PostgreSQL 10

## Development
```
# run rails server
git clone https://github.com/media-cf/ThankYou.git
bundle install --path vendor/bundle
bundle exec rails s
```

## How to deploy？

### Deploy on the Heroku dashboard
1. Create a new app with heroku
2. Connect to your thankyou repository on GitHub
3. And SLACK_APP_ID, SLACK_APP_SECRET to Config Vars
4. Deployable with heroku.
![image](https://user-images.githubusercontent.com/30608925/36359274-a6a8ec22-155c-11e8-99ce-f3a56c539f04.png)

### Deploy on the command line
Getting Started with Rails 6.x on Heroku
https://devcenter.heroku.com/articles/getting-started-with-rails6

## Contributing
Bug reports and pull requests are welcome on GitHub at https://github.com/media-cf/ThankYou

## License
The application is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
