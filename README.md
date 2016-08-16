# README

## TL;DR
```./start-developing```

## Details of what that script does

* mysql

1. Set up `config/database.yml` and run these:
```bash
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake db:seed
```
2. Create a `config/application.yml` and add your AWS info
```bash
AWS_KEY: [key]
AWS_SECRET: [secret]
```

## Deploy to production
```bash
bundle exec cap production deploy
```

How the models were created:
bundle exec rails g model SurveyGroup name:string instructions:string{2048} position:integer
bundle exec rails g model SurveyQuestion survey_group:references name:string{1024} type:string selection_type:string instructions:string{1024} position:integer
bundle exec rails g model QuestionOption survey_question:references name:string position:integer

