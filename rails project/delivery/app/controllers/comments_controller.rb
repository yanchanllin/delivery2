class CommentsController < ApplicationController
    before_action :set_comment, only: [:show, :edit, :update, :destroy]
    skip_before_action :verify_authenticity_token
    
    def index
      @comments = Comment.all
    end

    def show
      render json: @comment, status: 200
    end

    def new
      @comment = Comment.new
    end
  
    
    def edit
    end
  
    
    def create
      @comment = Comment.new(comment_params)
  
      respond_to do |format|
        if @comment.save
          @comments = Comment.all
          format.json { render json: @comments }
        else
          format.html { render :new }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end
    end
    
    # PATCH/PUT /comments/1
    def update
      respond_to do |format|
        if @comment.update(comment_params)
          format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
          format.json { render :show, status: :ok, location: @comment }
        else
          format.html { render :edit }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end
    end
  
  
    def destroy
      @comment.destroy
      respond_to do |format|
        format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  
    
    private
     
      def set_comment
        @comment = Comment.find(params[:id])
      end
  
      def comment_params
        params.require(:comment).permit(:content,:order_id)
      end
  end