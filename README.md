# РАЗВЕРТЫВАНИЕ САЙТА

Выполните последовательно команды в консоли, находясь в директории, в которой вы хотите развернуть проект.
Описание для среды, развернутой по инструкции https://gorails.com/setup/windows/10
Важно! Используются не самые актуальные ruby и гемы, так как изначально я начал делать проект по railstutorial (в среде AWS Cloud9) и так и продолжил. Чтобы избежать ошибок при развертывания проекта предлагаю использовать те же версии.

rbenv install 2.7.4

gem install rails -v 6.1.4.1

gem install bundler -v 2.2.17

curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update
sudo apt install yarn

Перейдите в папку, в которой планируете создать папку проекта и выполните:
git clone https://github.com/eugenezorkin/test2_app.git

cd test2_app

bundle _2.2.17_ install 
rails db:setup
rails db:migrate

yarn install --check-files

rails server (по умолчанию development) или 
rails server -e production (для загрузки в режиме production)


Для запуска выполнения задач (в данный момент выполнение задач не работает)
* установить Redis
sudo apt install redis-server
sudo systemctl start redis-server
sudo systemctl enable redis-server

* выполнить в консоли
resque:work QUEUE=*


# СТРУКТУРА САЙТА
Публичка:
/ - корень сайта
/news - публичная страница новостей, просто список новостей без пагинации. Можно перейти на деталку, кликнул по заголовку новости.
Ссылка на "Новости" размещена в главном меню сайта.

Для зарегистрированных пользователей:
/admin/profile - редактирование пользователем своих данных, по сути доступно только имя и настройка рассылки дайджеста.
Ссылка на "Профиль" доступна в выпадающем меню Аккаунта после авторизации пользователя.

Для редакторов:
/admin/news - страница для редакторов, позволяет добавлять, редактировать и удалять новостей. Осуществляется проверка прав доступа
Ссылка на "Новости" доступна в выпадающем меню Аккаунта после авторизации пользователя, отображается только у редакторов.

Для админов:
/admin/users - страница для админов, позволяет редактировать (в том числе назначать админами и редакторами) и удалять пользователей. Осуществляется проверка прав доступа. Также админы имеют доступ к редактированию новостей.
Ссылка на "Пользователи" доступна в выпадающем меню Аккаунта после авторизации пользователя, отображается только у админов.

# ЧТО СДЕЛАНО

## Реализация админского и редакторского типа записей.
Реализовал просто через поля admin и editor типа boolean. Были мысли использовать для реализации гем rolify и cancan, но в рамках постановки задачи булевых полей достаточно.

## Авторизация и регистрация с помощью гема Devise
Для кастомизации верстки view вынесены из гема в /app/views. Также с целью добавления дополнительных полей в форму регистрации соответствующий контроллер регистрации вынесен из Devise в app/controllers/users/registrations_controller.rb. 
Для этого контроллера скопированы из папки devise необходимые views.

## Страница "Нет доступа"
В папке public создана страница forbid.html для отображения пользователям, когда они пытаются получить доступ к странице, к которой у них нет доступа.

## Модель News
Поля title:string{255}, content:text, user_id:integer, last_editor_id:integer, edits_number:integer. Задана валидация полей title и content. Поле edits_number хранит количество редактирований. С помощью обработчика для before_save инкрементирует значение поля edits_number, а также контроллируем, что не превышено ограничение, иначе выдаем сообщение об ошибке.
Связана с моделью User отношением "многие-к-одному" по полю user_id


## Публичная страница новостей, контроллер news
/news - доступен просмотр списка новостей и деталки новостей. В routes.rb для контроллера News разрешены только вышеуказанные actions, чтобы исключить несанкционированное создание или редактирование новостей.

## Страница "Новости" для редакторов, контроллер admin/news
/admin/news
Реализована с помощью контроллера News, который размещен в модуле Admin. Было бы логичнее разместить в модуле Editor, но я уже поместил в Admin. Размещение в модуле позволило: 
1) сформировать урл /admin/users (что в принципе можно было достигнуть используя namespace)
2) использовать контроллер с именем, который уже используется в проекте.
Ограничение доступа реализовано с помощью обработчика для before_action, который проверяет у пользователя current_user.editor?


Использует ту же модель News, которую и публичный контроллер News

## Модель User
Поля email:string, password, name:string{255}, editor:boolean, admin:boolean, digest:enum[nodigest,weekly,dayly]. Задана валидация полей email, name. Перед сохранением задаем поле digest=weekly

## Страница "Профиль"
/profile
Реализована с помощью контроллера Users, который используется только для этой цели - отображение страницы edit и действия update. Защита от несанкционированного доступа реализована посредством ограничений доступных экшнов в routing только edit и update.
Также в контроллере для before_action назначен обработчик, который назначает переменной @user текущего пользователя. Это необходимо, так как ссылка на профиль не предполагает передачи ID пользователя, так как для профиля это лишнее, кроме этого исключает возможность передачи параметров для изменения другого пользователя.
Если на Профиль перейдет неавторизованный пользователь, то он увидит страницу с сообщением об отстутсвии доступа к страницею.
Использует вышеуказанную модуль User


## Страница "Пользователи" для админов
/admin/users
Реализована с помощью контроллера Users, который размещен в модуле Admin.
Ограничение доступа реализовано с помощью обработчика для before_action, который проверяет у пользователя current_user.admin?
Использует вышеуказанную модуль User

## Рассылка дайджеста
Для еженедельной и ежедневной рассылок сгенерены соответствующие Mailer, а для них Job. Чтобы выполнять рассылку в заданное время установлены resque и resque-scheduler. В файле config/rescue_scheduler.yml прописаны задачи. По идее job должны запускаться по расписанию, но, к сожалению, сходу завести не удалось. При запуске rescue пишет, что задача запущена, но логирование показывает, что не вызывается метод perform у Job и при этом не выдает никакой ошибки. Пытался удалить сам метод perform и даже наследование, чтобы исключить вызов наследуемого метода, но ошибок не пишет. В логе видно, что задача попала в очередь и запустилась, но действия в функции perform не выполняются. При вызове метода из кода, напримеро, TestJob.perform_now все отрабатывает. Я пока не стал дальше разбираться.

## Bootstrap
Подключен гем bootstrap-sass.

## erb to slim
Я изначально все делал на erb. Потом конвертнул с помощью гема html2slim. Работа rails со slim налажена посредством устанвоки гема slim-rails

## Функциональное тестирование
Контроллеры геренировались командой rails scaffold_controller, поэтому тесты для контроллеров, в принципе, были готовы. Но после внесенных мной изменений в контроллеры тесты выдавали около 15 ошибок, которые я отладил.

## Интеграционное тестирование
Написал интеграционный тест для тестирования функционала новостей для редакторов. Тест включает в себя проверку всего цикла - создание, редактирование и удаление.


# НЕСДЕЛАННЫЕ ПУНКТЫ ЗАДАНИЯ

* отправка уведомления редактору после сохранения правок (не сделано, надо было уточнить задачу, но я не уточнил)

# НЕРЕШЕННЫЕ ПРОБЛЕМЫ

* выполнение задач отправки рассылки по расписанию resque-scheduler (почему-то не отрабатывает вызов метода perform у job)
* просмотр preview NewsMailer - при превышении определенного количества кириллических символов выводит вместо письма выводится фрагмент текста из нечитаемых символов. При этом при использовании коротких кириллических текстов или если текст написан латиницей, тогда все ок.