require 'rails_helper'

RSpec.describe "Articles", type: :request do
  let(:user) { FactoryBot.create :user }
  let(:valid_headers) {
    { Authorization: "Token #{user.api_token}" }
  }

  describe "GET /articles" do
    subject {
      get articles_path, headers: valid_headers
    }
    it 'success' do
      subject
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /articles/:id" do
    let!(:article) { FactoryBot.create :article, user: user }
    subject {
      get article_path(article), headers: valid_headers
    }
    it 'success' do
      subject
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /articles" do
    let(:valid_params) { { title: 'text', body: 'sample' }}
    let(:invalid_params) { { title: '', body: 'sample' }}
    context 'with valid params' do
      subject {
        post articles_path, params: valid_params, headers: valid_headers
      }
      it 'success' do
        subject
        expect(response).to have_http_status(200)
      end
    end

    context 'with invalid params' do
      subject {
        post articles_path, params: invalid_params, headers: valid_headers
      }
      it 'fails' do
        subject
        expect(response).to have_http_status(422)
      end
    end
  end

  describe "PUT /articles/:id" do
    let(:valid_params) { { title: 'text', body: 'sample' }}
    let(:invalid_params) { { title: '', body: 'sample' }}
    let!(:article) { FactoryBot.create :article, user: user }

    context 'with valid params' do
      subject {
        put article_path(article), params: valid_params, headers: valid_headers
      }
      it 'success' do
        subject
        expect(response).to have_http_status(200)
      end
    end

    context 'with invalid params' do
      subject {
        put article_path(article), params: invalid_params, headers: valid_headers
      }
      it 'fails' do
        subject
        expect(response).to have_http_status(422)
      end
    end

    context 'another user' do
      let(:another_user) { FactoryBot.create :user }
      let(:valid_headers) {
        { Authorization: "Token #{another_user.api_token}" }
      }
      subject {
        put article_path(article), params: valid_params, headers: valid_headers
      }

      it 'fails' do
        subject
        expect(response).to have_http_status(401)
      end
    end
  end

  describe "DELETE /articles/:id" do
    let!(:article) { FactoryBot.create :article, user: user }
    subject {
      delete article_path(article), headers: valid_headers
    }
    context 'request article author' do
      it 'success' do
        subject
        expect(response).to have_http_status(204)
      end
    end

    context 'request another_user' do
      let(:another_user) { FactoryBot.create :user }
      let(:valid_headers) {
        { Authorization: "Token #{another_user.api_token}" }
      }
      subject {
        delete article_path(article), headers: valid_headers
      }
      it 'success' do
        subject
        expect(response).to have_http_status(401)
      end
    end
  end
end
