class TweetsController < ApplicationController
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!, except: [:new, :create, :show]
  # GET /tweets
  # GET /tweets.json
  
  def index
    
    friends = Friend.where("user_id=?" , current_user&.id)
    #obtengo los amigos del usuario
    aux2=friends.pluck :friend_id
    #saco los twitter de los amigos
    if params[:content].present?
      aux = Tweet.where(user_id: aux2)
      aux2 = aux.where("post ILIKE ?", "%#{params[:content]}%")
      @tweets = aux2.order("created_at DESC").page(params[:page]).per_page(5)
    else
      aux = Tweet.where(user_id: aux2)
      @tweets = aux.order("created_at DESC").page(params[:page]).per_page(5)
    end

  end

  # GET /tweets/1
  # GET /tweets/1.json
  def show
    
  end

  # GET /tweets/new
  def new
    @tweet = Tweet.new
  end

  # GET /tweets/1/edit
  def edit
  end

  # POST /tweets
  # POST /tweets.json
  def create
    
    @tweet = current_user.tweets.new(tweet_params)
    
    respond_to do |format|
      if @tweet.save
        format.html { redirect_to @tweet, notice: 'Tweet was successfully created.' }
        format.json { render :show, status: :created, location: @tweet }
      else
        format.html { render :new }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
    extract_name_hash_tags.each do |name|
      HashTag.create(name: name)
    end
  end

  def extract_name_hash_tags
    @tweet.post.to_s.scan(/#\w+/).map{|name| name.gsub("#", "")}
  end
 
 
 
  # PATCH/PUT /tweets/1
  # PATCH/PUT /tweets/1.json
  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.html { redirect_to @tweet, notice: 'Tweet was successfully updated.' }
        format.json { render :show, status: :ok, location: @tweet }
      else
        format.html { render :edit }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tweets/1
  # DELETE /tweets/1.json
  def destroy
    @tweet.destroy
    respond_to do |format|
      format.html { redirect_to tweets_url, notice: 'Tweet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  
  
  
  
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tweet_params
      params.require(:tweet).permit(:post)
    end
end
