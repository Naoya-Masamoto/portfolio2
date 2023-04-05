module ApplicationHelper
  def color_icon_url(color_code)
    tag.i("", class: "color-icon", style: "background-color: #{color_code}")
  end
end

