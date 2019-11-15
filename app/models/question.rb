class Question < ApplicationRecord
  # Эта команда добавляет связь с моделью User на уровне объектов, она же
  # добавляет метод .user к данному объекту.

  # Когда мы вызываем метод user у экземпляра класса Question, рельсы
  # поймут это как просьбу найти в базе объект класса User со значением id,
  # который равен question.user_id.
  belongs_to :user

  # Имя этой связи важно:
  # рельсы добавят к нему `_id` и найдут нужное поле в таблице
  belongs_to :author, class_name: 'User', optional: true

  validates :text, :user, presence: true
  validates :text, length: { maximum: 255 }
end
