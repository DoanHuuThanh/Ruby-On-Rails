# frozen_string_literal: true

module ApplicationHelper
  def full_title(page_title = '')
    base_title = 'Ruby on Rails Tutorial Sample App'
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end
end

# Helper modules trong Rails được sử dụng để chứa các phương thức hỗ trợ
# (helpers) mà bạn muốn sử dụng trong views, controllers, hoặc bất kỳ thành phần nào khác của ứng dụng Rails.
