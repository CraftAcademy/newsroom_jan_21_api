RSpec.describe 'GET /api/articles', type: :request do
  let!(:article) { 3.times { create(:article) } }
  describe 'successfully' do
    let!(:article) { 3.times { create(:article, category: 'news') } }
    before do
      get '/api/articles?category=news'
    end

    it 'responds with a 200 status' do
      expect(response).to have_http_status 200
    end

    it 'responds with a list of 3 articles' do
      expect(response_json['articles'].count).to eq 3
    end

    it 'responds with the category as an attribute' do
      expect(response_json['articles'].first['category']).to eq 'news'
    end
  end

  describe 'unsuccessfully with no articles of that category' do
    before do
      get '/api/articles?category=news'
    end

    it 'responds with a 404' do
      expect(response).to have_http_status 404
    end

    it 'responds with a message' do
      expect(response_json['message']).to eq 'Unfortunately we did not find any articles with this category.'
    end
  end
end
