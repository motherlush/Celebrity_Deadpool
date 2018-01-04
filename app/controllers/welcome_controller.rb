class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :privacy]

  def index
  end
end
