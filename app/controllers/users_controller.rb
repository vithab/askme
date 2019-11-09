class UsersController < ApplicationController
  # Это действие отзывается, когда пользователь заходит по адресу /users
  def index
    # Мы создаем массив из двух болванок пользователей. Для создания фейковой
    # модели мы просто вызываем метод User.new, который создает модель, не
    # записывая её в базу.
    @users = [
        User.new(
            id: 1,
            name: 'Vasiliy',
            username: '@vasko',
            avatar_url: 'http://avatarmaker.ru/img/11/1020/101960.jpg'
        ),
        User.new(id: 2, name: 'Ledger', username: 'joker')
    ]
  end

  def new
  end

  def edit
  end

  def show
    @user = User.new(
      name: 'Vasiliy',
      username: 'vasko',
      avatar_url: 'http://avatarmaker.ru/img/11/1020/101960.jpg'
    )

    @questions = [
      Question.new(text: 'Где вы работаете?', created_at: Date.parse('01.11.2019')),
      Question.new(text: 'Из какого вы города?', created_at: Date.parse('02.11.2019'))
    ]

    @new_question = Question.new
  end
end
