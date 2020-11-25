class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_author!, except: [ :index, :show]
  before_action :correct_author, only: [:edit, :update, :destroy]
  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.all
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
     @article = Article.find(params[:id])
     @comment = Comment.new
     @comment.article_id = @article_id
  end

  # GET /articles/new
  def new
    #@article = Article.new
    @article = current_author.articles.build
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    #@article = Article.new(article_params)
    @article = current_author.articles.build(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  def correct_author
    @article = current_author.articles.find_by(id: params[:id])
    redirect_to articles_path, notice: "Not Authorized To Edit This article" if@article.nil?
  end

  def change_status
    @article = Article.find_by_id(params[:article_id])
    @article.update_attribute(:status, "archived")
    redirect_to @article, notice: "An Article Status has been changed!"
  end  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :description, :tag_list, :image, :author_id, :status)
    end
end
