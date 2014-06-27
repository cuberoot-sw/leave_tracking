class HomeController < ApplicationController
  def index
    if current_user.present?
      @total_leaves, @balance_leaves= current_user.collect_leaves_count
      @birthdays = User.birthdays
      @resources = current_user.is_employee? ? [] : current_user.resources
    end
  end
end
