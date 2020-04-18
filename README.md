# README

## table
- user
  - id
  - name : string
  - email : string
  - password_digest : string
  - admin : integer

- task
  - id
  - name : string
  - content : text
  - end_date : date
  - priority : integer
  - status : integer
  - user_id : integer

- labeling
  - id
  - task_id : integer
  - label_id : integer

- label
  - id
  - name : string


## Heroku デプロイ方法
- アセットコンパイル
　$ bundle exec rails assets:precompile RAILS_ENV=production

- Herokuのアプリを新規作成
  $ heroku create

- Herokuにログイン
　$ heroku login

- コミットする
  $ git add -A
  $ git commit -m " "

- Herokuにデプロイをする
  $ git push heroku master

- データベースの移行
　$ heroku run rails db:migrate
