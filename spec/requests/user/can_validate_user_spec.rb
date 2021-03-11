RSpec.describe 'GET /api/auth/validate_token', type: :request do
  let(:user) { create(:user) }
  let(:auth_headers) {user.create_new_auth_token}
  describe 'successfully' do
    before do
      get '/api/auth/validate_token',
          headers: auth_headers
    end

    it 'responds with a 200 status' do
      expect(response).to have_http_status 200
    end

    it 'responds with the headers' do
      expect(response.headers['access-token']).to eq auth_headers['access-token'] 
    end
  end

  describe 'unsuccessfully' do
    before do
      get '/api/auth/validate_token'
    end

    it 'responds with a 401 status' do
      expect(response).to have_http_status 401
    end

    it 'doesnt respond with access headers' do
      expect(response.headers['access-token']).not_to be
    end
  end
end
