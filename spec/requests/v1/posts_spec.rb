# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Posts', type: :request do

  describe 'GET /api/v1/posts #index' do
    it 'returns http success ' do
      get '/api/v1/posts'
      expect(response.status).to eq 200
    end
  end

  describe 'GET /api/v1/posts/:id' do
    let(:post) { create(:post) }

    before do
      get "/api/v1/posts/#{post.id}"
    end

    it 'returns http success' do
      expect(response.status).to eq 200
    end

    it 'include parameters' do
      expect(JSON.parse(response.body)['data']['title']).to eq(post.title)
    end
  end

  describe 'POST /api/v1/posts #create' do
    let(:valid_post_params) { attributes_for(:post) }
    let(:invalid_post_params) { attributes_for(:post, title: '') }

    context 'when valid parameters' do
      before do
        post '/api/v1/posts', params: { post: valid_post_params }
      end

      it 'returns http success' do
        expect(response.status).to eq 200
      end

      it 'responses must be correct' do
        expect(JSON.parse(response.body)['status']).to eq('success')
      end

      it 'increases post data' do
        expect { post '/api/v1/posts', params: { post: valid_post_params } }.to change(Post, :count).by(+1)
      end
    end

    context 'when invalid parameters' do
      before do
        post '/api/v1/posts', params: { post: invalid_post_params }
      end

      it 'responses must be correct' do
        expect(JSON.parse(response.body)['status']).to eq('error')
        expect(JSON.parse(response.body)['message']).to eq('Posts could not be created')
      end
  
      it 'when invalid parameters does not increase post data' do
        expect { post '/api/v1/posts', params: { post: invalid_post_params } }.to_not change(Post, :count)
      end
    end
  end

  describe 'PUT /api/v1/post/:id #update' do
    let!(:post) { create :post }
    let(:valid_post_params) { attributes_for(:post) }

    context 'with valid parameters' do
      before do
        put "/api/v1/posts/#{post.id}", params: { post: valid_post_params }
      end

      it 'returns http success' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns success status in response body' do
        expect(JSON.parse(response.body)['status']).to eq('success')
      end
    end
  end

  describe 'DELETE /api/v1/post/:id #destroy' do
    let!(:post) { create :post }

    it 'decrease post data' do
      expect { delete "/api/v1/posts/#{post.id}" }.to change(Post, :count).by(-1)
    end
  end
end
