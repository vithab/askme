# В этом файле мы можем писать вспомогательные методы (хелперы) для
# шаблонов (view) нашего приложения.
module ApplicationHelper
  # Этот метод возвращает ссылку на автарку пользователя, если она у него есть.
  # Или ссылку на дефолтную аватарку, которая лежит в app/assets/images
  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_path 'avatar_joker.jpg'
    end
  end

  # Хелпер, рисующий span тэг с иконкой из font-awesome
  def fa_icon(icon_class)
    content_tag 'span', '', class: "fa fa-#{icon_class}"
  end

  # Метод для склонения слова "вопрос"
  # 1 крокодил — именительный падеж, единственное число
  # 2 крокодила — родительный падеж, единственное число
  # 8 крокодилов — родительный падеж, множественное число
  def incline(number, krokodil, krokodila, krokodilov)
    # Сначала, проверим входные данные на правильность
    if number == nil || !number.is_a?(Numeric)
      # Допустим, первый параметр пустой или не является числом (строка). Будем
      # считать, что нас это устроит, просто продолжаем как будто он нулевой.
      number = 0
    end

    ostatok100 = number % 100

    if ostatok100.between?(11, 14)
      return krokodilov
    end

    # Так как склонение определяется последней цифрой в числе, вычислим остаток
    # от деления числа number на 10
    ostatok = number % 10

    # Для 1 — именительный падеж (Кто?/Что? — крокодил)
    if ostatok == 1
      return krokodil
    end

    # Для 2-4 — родительный падеж (2 Кого?/Чего? — крокодилов)
    if ostatok >= 2 && ostatok <= 4
      return krokodila
    end

    # 5-9 или ноль — родительный падеж и множественное число (8 Кого?/Чего? —
    # крокодилов)
    if (ostatok >= 5 && ostatok <= 9) || ostatok == 0
      return krokodilov
    end
  end
end
