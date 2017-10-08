# frozen_string_literal: true

class WelcomeController < ApplicationController
  SECTIONS = ["documentation"]

  expose(:section) { (SECTIONS & [params[:action]]).first || "home" }
end
