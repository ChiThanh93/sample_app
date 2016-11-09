module ApplicationHelper
  def full_title(page_title = '')
    base_title = I18n.t".Ruby on Rails Tutorial Sample App"
    page_title.empty? ? base_title : page_title + " | " + base_title
  end
end
