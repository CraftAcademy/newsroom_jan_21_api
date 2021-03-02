RSpec.describe 'GET /api/articles', type: :request do
  let!(:test_article1) { create(:article) }
  let!(:test_article2) { create(:article) }
  let!(:test_article3) { create(:article) }
  let!(:test_article4) { create(:article) }
  let!(:test_article5) { create(:article) }
  describe 'successfully' do
    before do
      get '/api/articles'
    end

    it 'responds with a 200 status' do
      binding.pry
      expect(response).to have_http_status 200
    end

    it 'responds with a list of 5 articles' do
      expect(response.json['articles'].length).to be eq 5
    end

    it 'responds with newest article first in the list' do
      expect(response.json['articles'].first['title']).to eq 'Test Article 4'
      expect(response.json['articles'].second['title']).to eq 'Test Article 1'
    end
  end
end
