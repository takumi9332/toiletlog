class ToiletsController < ApplicationController
  def index
    @toilets = Toilet.all
  end

  def new
    @Toilet = Toilet.new
  end
end
