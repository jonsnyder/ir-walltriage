Walltriage::Application.routes.draw do
  resources :sentences

  resources :stat_values

  resources :stopwords

  resources :stopword_lists

  resources :stats

  resources :lda_post_topics

  resources :lda_post_tags

  resources :strategies do
    member do
      post 'run'
    end
  end

  resources :lda_topic_words

  resources :lda_topics

  resources :mallet_commands
  resources :mallet_runs do
    member do
      post 'run'
      post 'run_validation'
      get 'jobs'
    end
  end

  resources :user_comment_tags

  resources :user_post_tags, :only => [:update, :destroy]

  resources :datasets

  resources :comments

  resources :posts, :only => [:index, :update]

  resources :pages

  resources :access_tokens do
    collection do
      get 'fb'
      get 'log_out'
    end
  end

  get "home/index"
  get "home/instructions"

  root :to => "home#index"
end
