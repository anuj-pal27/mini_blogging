class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  def after_sign_in_path_for(resource)
    posts_path
  end

  allow_browser versions: :modern
end
