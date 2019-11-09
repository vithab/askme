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
end
