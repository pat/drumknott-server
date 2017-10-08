# frozen_string_literal: true

class WelcomeController < ApplicationController
  SECTIONS = ["documentation"].freeze

  expose(:section) { (SECTIONS & [params[:action]]).first || "home" }
end
