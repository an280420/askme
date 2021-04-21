# Askme

## Описание

Сайт где пользователи могут задавать вопросы и получать на них ответы. После регистрации пользователь заполняет свою анкету и может начать - как от своего имени, так и анонимно - задавать свои вопросы и отвечать на вопросы других пользователей. Пользователь может установить свой аватар для отображения на главной странице и в профиле пользователя. Приложение выводит на главную страницу все хештеги, которые были в вопросах. Приложение имеет упрощенный фунционал по аутентификации пользователей. Для более расширенного функционала рекомендуется использовать уже готовые сторонние решения - gem 'devise'.

## Работающий проект

Как работает приложение вы можете посмотреть на heroku
https://askfromural.herokuapp.com/

## Установка

Для корректной работы приложения на Вашем компьютере должны быть установлены Ruby 2.7.2 и Rails 6.0.3

```
$ git clone https://github.com/an280420/askme.git
$ cd ./askme
$ bundle install --without production
$ yarn install --check-files
$ rails db:migrate
```

## Дополнительные функции

Вы можете использовать в приложении reCPTCHA v.2 - Google. 
Для этого нужно получить соответствующие [ключи](https://www.google.com/recaptcha/about/) и прописать их в askme/.env, как показано ниже. Создайте файл .env в корне проекта

```
$ touch .env
```
Запишите в пустой файл .env следующие две строки.

```
RECAPTCHA_ASKME_PUBLIC_KEY="<здесь пишем ваш public ключ>"
RECAPTCHA_ASKME_PRIVATE_KEY="<здесь пишем ваш private ключ>"
```
> :warning: **ВАЖНО!**: Не храните файлы ```master.key,  .env``` в публичных репозиториях!

Сохраните внесенные изменения в .env

## Запуск

Запуск на локальной машине осуществляется командой

```
$ bundle exec rails s
```
Приложение находится по адресу ```http://localhost:3000/```
