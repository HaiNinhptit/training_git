class CartsController < ApplicationController
  layout :dynamic_layout

  def index
  end

  private

    def dynamic_layout
      if user_signed_in?
        "application"
      else
        "guest"
      end
    end
end