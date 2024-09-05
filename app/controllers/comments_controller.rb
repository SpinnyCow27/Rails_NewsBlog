class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: [:destroy]
  before_action :authorize_user!, only: [:destroy]

  def destroy
    @post = Post.find(params[:post_id]) # Asegúrate de que esta línea esté obteniendo el post correctamente
    @comment = @post.comments.find_by(id: params[:id])
  
    if @comment
      @comment.destroy
      redirect_to @post, notice: 'Comentario eliminado.'
    else
      redirect_to @post, alert: 'Comentario no encontrado.'
    end
  end
  def set_comment
    @comment = Comment.find(params[:id])
  end


  def authorize_user!
    redirect_to root_path, alert: 'No autorizado' unless @comment.user == current_user
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user  # Asegura que el comentario esté asociado con el usuario actual
    if @comment.save
      redirect_to @post, notice: 'Comentario publicado.'
    else
      redirect_to @post, alert: 'Error al publicar el comentario.'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
