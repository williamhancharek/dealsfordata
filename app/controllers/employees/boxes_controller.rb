class Employees::Boxes::BoxesController < ApplicationController

  def index
    @boxes = Box.all

  end

  def show

  end

end
