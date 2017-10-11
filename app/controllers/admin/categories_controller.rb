class Admin::CategoriesController < ApplicationController
  def index
  end

  def new
    @Category = Category.new
  end

  def create
  end
end
