class PostsController < ApplicationController
  include IsLoggedIn
  
  def index
    @posts = Post.where(:dataset_id => params[:dataset]).order("created_time")
    if params[:tags_filter_type] == 'untagged'
      @posts = @posts.untagged
    elsif params[:tags_filter_type] == 'all' && !params[:tags_filter_all].blank?
      @posts = @posts.tags_all( params[:tags_filter_all].split(','))
    elsif params[:tags_filter_type] == 'any' && !params[:tags_filter_any].blank?
      @posts = @posts.tags_any( params[:tags_filter_any].split(','))
    end

    if params[:search_filter]
      @posts = @posts.search( params[:search_filter])
    end

    @base_params = params.select { |k,v| k != 'controller' && k != 'action' }
    respond_to do |format|
      format.html { 
        @posts = @posts.page( params[:page])
        @tags = UserPostTag.user( @user).dataset( params[:dataset]).count(:group => 'user_post_tags.tag')
        # UserPostTag.find_by_sql('select tag, count(*) as c FROM user_post_tags JOIN posts on posts.id = user_post_tags.post_id GROUP BY tag').each { |tag| @tags[tag.tag] = tag.c}
        

                                                                                                                                                        }
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
