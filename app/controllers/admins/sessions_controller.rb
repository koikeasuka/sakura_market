class Admins::SessionsController < Devise::SessionsController
  def after_sign_in_path_for(resource)
    admins_items_path
  end
end
