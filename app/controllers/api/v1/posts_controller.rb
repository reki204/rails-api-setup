# frozen_string_literal: true

module Api
  module V1
    class PostsController < ApplicationController
      before_action :set_posts, only: %i[show update destroy]

      def index
        posts = Post.order(created_at: :desc)
        render json: { status: 'success', message: 'Posts loaded successfully', data: posts }
      end

      def show
        render json: { status: 'success', message: 'Posts loaded successfully', data: @post }
      end

      def create
        post = Post.new(post_params)
        if post.save
          render json: { status: 'success', message: 'Posts successfully created', data: post }
        else
          render json: { status: 'error', message: 'Posts could not be created', data: post.errors }
        end
      end

      def update
        if @post.update(post_params)
          render json: { status: 'success', message: 'Posts successfully updated', data: @post }
        else
          render json: { status: 'error', message: 'Posts could not be updated', data: @post.errors }
        end
      end

      def destroy
        @post.destroy
        render json: { status: 'success', message: 'Posts successfully destroyed', data: @post }
      end

      private

      def set_posts
        @post = Post.find(params[:id])
      end

      def post_params
        params.require(:post).permit(:title, :content)
      end
    end
  end
end
