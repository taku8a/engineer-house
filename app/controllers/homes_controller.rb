class HomesController < ApplicationController
  def top
    @posts = Post.newly
  end

  def about
  end
end
