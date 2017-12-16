RSpec.describe "Users", type: :request do
  describe "GET /users/:id" do
    let(:user) { FactoryBot.create :user }
    subject { get user_path(user) }
    it 'success' do
      subject
      expect(response).to be_success
    end
  end

  describe "POST /users" do
    context '適切なパラメータを与えた場合' do
      subject {
        post users_path, params: {
          email: 'sample@sample.com',
          password: 'a' * 8,
        }
      }

      it 'success' do
        subject
        expect(response).to be_success
      end

      it 'ユーザー数が増える' do
        expect {
          subject
        }.to change(User, :count).by(1)
      end
    end

    context 'パラメータが不適切な場合' do
      subject {
        post users_path, params: {
          email: 'not_include_domain',
          password: 'short'
        }
      }

      it 'failure' do
        subject
        expect(response).not_to be_success
      end

      it 'ユーザー数が増えない' do
        expect {
          subject
        }.not_to change(User, :count)
      end
    end
  end
end
