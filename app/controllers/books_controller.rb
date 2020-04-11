class BooksController < ApplicationController
  before_action :baria_user, only: [:edit]

  def show
    @book         = Book.new
    @books        = Book.find(params[:id])
    @user         = @books.user
    @book_comment = BookComment.new
    @book_comments = @books.book_comments
  end

  def index
    @books = Book.all #一覧表示するためにBookモデルの情報を全てくださいのall
    @book  = Book.new
    @user = current_user
  end

  def create
    @book      = Book.new(book_params) #Bookモデルのテーブルを使用しているのでbookコントローラで保存する。
    @books     = Book.all
    @book.user = current_user
  	if @book.save #入力されたデータをdbに保存する。
  		redirect_to @book, notice: "successfully created book!"#保存された場合の移動先を指定。
  	else
  		render 'index'
  	end
  end

  def edit
  	@book = Book.find(params[:id])
  end

  def update
  	@book = Book.find(params[:id])
  	if @book.update(book_params)
  		redirect_to @book, notice: "successfully updated book!"
  	else #if文でエラー発生時と正常時のリンク先を枝分かれにしている。
  		render "edit"
  	end
  end

  def destroy
  	@books = Book.find(params[:id])
  	@books.destroy
  	redirect_to books_path, notice: "successfully delete book!"
  end

  # def search
  # @user_or_book = params[:option]
  # @how_search = params[:choice]
  # if @user_or_book = "1"
  #   @users = User.search(params[:search],@user_or_book, @how_search)
  # else @user_or_book = "2"
  #   @user.books = Book.all
  #   @books = Book.search(params[:search],@user_or_book, @how_search)
  # end
  #   render "searches/search"
  # end

  private

  def baria_user
    @book = Book.find(params[:id])
    @user = @book.user
    if @user != current_user
    redirect_to books_path
    end
  end
  #url直接防止　メソッドを自己定義してbefore_actionで発動。#

  def book_params
  	params.require(:book).permit(:title, :body, :user_id)
  end

end
