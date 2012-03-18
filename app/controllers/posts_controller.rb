class PostsController < ApplicationController
  include IsLoggedIn
  
  def index
    @posts = Post.where(:dataset_id => params[:dataset])
    respond_to do |format|
      format.html
      format.mallet { render mallet: @posts }
    end
  end

  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_tags(params[:tags], @user)
        format.json { head :no_content }
      else
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

end
