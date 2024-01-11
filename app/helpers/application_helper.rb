# frozen_string_literal: true

# Module application
module ApplicationHelper
  def full_title(page_title = '')
    base_title = 'Ruby on Rails Tutorial Sample App'
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  def render_reaction_icon(action_type)
    case action_type
    when 'like' || 0
      image_tag('like.svg', class: 'icon transition ease-in-out delay-150 hover:-translate-y-1 hover:scale-110 duration-300')
    when 'love' || 1
      image_tag('love.svg', class: 'icon transition ease-in-out delay-150 hover:-translate-y-1 hover:scale-110 duration-300')
    when 'haha' || 2
      image_tag('haha.svg', class: 'icon transition ease-in-out delay-150 hover:-translate-y-1 hover:scale-110 duration-300')
    when 'wow' || 3
      image_tag('wow.svg', class: 'icon transition ease-in-out delay-150 hover:-translate-y-1 hover:scale-110 duration-300')
    when 'sad' || 4
      image_tag('sad.svg', class: 'icon transition ease-in-out delay-150 hover:-translate-y-1 hover:scale-110 duration-300')
    when 'angry' || 5
      image_tag('angry.svg', class: 'icon transition ease-in-out delay-150 hover:-translate-y-1 hover:scale-110 duration-300')
    end
  end
end
