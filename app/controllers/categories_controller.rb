class CategoriesController < ApplicationController

  def index
    @brands = Brand.all.order(:name).group_by{ |brand| brand.name[0] }
  end
end
