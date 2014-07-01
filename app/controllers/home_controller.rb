class HomeController < ApplicationController
  require 'will_paginate/array'
  def index
    if current_user.present?
      @total_leaves, @balance_leaves= current_user.collect_leaves_count
      @birthdays = User.birthdays
      @resources = current_user.is_employee? ? [] : current_user.resources.paginate(:page => params[:page], :per_page => 5)
    end
  end
end
