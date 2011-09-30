class ApplicationController < ActionController::Base
  protect_from_forgery

  def init_layout_data
    @links = Link.all;
  end
  def page_title
    "Rubly- Url Shortener"
  end
end
