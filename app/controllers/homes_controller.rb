class HomesController < ApplicationController
  def top
    @posts = Post.limit(5).order('id DESC')
  end

  def about
  end
end
