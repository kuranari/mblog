require 'rails_helper'

RSpec.describe "Favorites", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:article) { FactoryBot.create(:article, user: user) }
  let(:valid_headers) {
    { headers: { Authorization: "Token #{user.api_token}" } }
  }
  describe "PUT /articles/:article_id/favorites" do
    subject do
      put article_favorites_path(article), valid_headers
    end

    context 'favorites not exists' do
      it "success" do
        subject
        expect(response).to have_http_status(204)
      end
    end

    context 'favorites still exists' do
      before do
        FactoryBot.create(:favorite, user: user, article: article)
      end

      it "success" do
        subject
        expect(response).to have_http_status(204)
      end
    end
  end

  describe "DELETE /articles/:article_id/favorites" do
    subject do
      delete article_favorites_path(article), valid_headers
    end

    context 'favorites not exists' do
      it "success" do
        subject
        expect(response).to have_http_status(204)
      end
    end

    context 'favorites still exists' do
      before do
        FactoryBot.create(:favorite, user: user, article: article)
      end

      it "success" do
        subject
        expect(response).to have_http_status(204)
      end
    end
  end
end
