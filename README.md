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
