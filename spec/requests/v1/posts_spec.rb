# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let!(:post) { create(:post) }

  describe 'GET /api/v1/posts #index' do
    it 'returns http success ' do
      get '/api/v1/posts'
      expect(response.status).to eq 200
    end
  end

  describe 'GET /api/v1/posts' do
    it 'sending data' do
      get '/api/v1/posts'
      expect(JSON.parse(response.body)['data'].first['id']).to eq(post['id'])
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

  describe 'POST /api/v1/posts' do
    let(:post) { create(:post) }
    let(:valid_post_params) { attributes_for(:post) }
    let(:invalid_post_params) { attributes_for(title: '') }
    before do
      post '/api/v1/posts', params: params
    end
    context 'when valid parameters' do
      let(:params) do
        {
          title: 'test title',
          content: 'test content'
        }
      end
      it 'returns http success' do
        expect(response.status).to eq 200
      end

      it 'responses must be correct' do
        expect(JSON.parse(response.body)['status']).to eq('success')
      end

      it 'increases post data' do
        expect { post '/api/v1/posts', params: params }.to change(Post, :count).by(+1)
      end
    end
  end

  describe 'PUT /api/v1/post/:id' do
    let!(:post) { create :post }
    let(:valid_post_params) { attributes_for(:post) }

    context 'when valid parameters' do
      it 'returns http success' do
        put "/api/v1/posts/#{post.id}", params: { post: valid_post_params }
        expect(response.status).to eq 200
      end

      it 'responses must be correct' do
        put "/api/v1/posts/#{post.id}", params: { post: valid_post_params }
        expect(JSON.parse(response.body)['status']).to eq('success')
      end
    end
  end

  describe 'DELETE /api/v1/post/:id' do
    let!(:post) { create :post }

    it 'decrease post data' do
      expect { delete "/api/v1/posts/#{post.id}" }.to change(Post, :count).by(-1)
    end
  end
end
