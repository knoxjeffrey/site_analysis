class AuthenticatesController < ApplicationController
  before_filter :authenticate_user!
end