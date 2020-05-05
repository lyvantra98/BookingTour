module ApplicationHelper
  include Pagy::Frontend

  def pages_number index, page
    page ||= 1
    index.to_i + (page.to_i - 1) * Settings.page.page_number_admin + 1
  end

  def comment_user? comment
    current_user.id == comment.user_id
  end

  def current_user? user
    user == current_user
  end

  def is_admin?
    current_user.is_admin == true
  end
end
