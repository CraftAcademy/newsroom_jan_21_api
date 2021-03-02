RSpec.describe 'GET /api/articles', type: :request do
  let!(:test_article1) { create(:article, created_at: Time.current - 5.days) }
  let!(:test_article2) { create(:article, title: 'Test Article 2', created_at: Time.current - 2.days) }
  let!(:test_article3) { create(:article, created_at: Time.current - 3.days) }
  let!(:test_article4) { create(:article, created_at: Time.current - 4.days) }
  let!(:test_article5) { create(:article, title: 'Test Article 5', created_at: Time.current - 1.days) }
  describe 'successfully' do
    before do
      get '/api/articles'
    end

    it 'responds with a 200 status' do
      expect(response).to have_http_status 200
    end

    it 'responds with a list of 5 articles' do
      expect(response_json['articles'].length).to eq 5
    end

    it 'responds with newest article first in the list' do
      expect(response_json['articles'].first['title']).to eq 'Test Article 5'
      expect(response_json['articles'].second['title']).to eq 'Test Article 2'
    end

    it 'the articles are expected not to contain the body' do
      expect(response_json['articles'].first['body']).to eq nil
    end

    it 'renders articles with expected teaser' do
      expect(response_json['articles'].first['teaser']).to eq 'MyTeaser'
    end

    it 'renders articles with expected title' do
      expect(response_json['articles'].first['category']).to eq 'story'
    end
  end
end
