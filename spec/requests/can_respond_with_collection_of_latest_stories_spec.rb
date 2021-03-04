RSpec.describe 'GET /api/articles', type: :request do
  let!(:test_experience) { create(:article, article_type: 'experience') }
  let!(:test_article1) { create(:article, created_at: Time.current - 5.days) }
  let!(:test_article2) { create(:article, title: 'Test Article 2', created_at: Time.current - 2.days) }
  let!(:test_article3) { create(:article, created_at: Time.current - 3.days) }
  let!(:test_article4) { create(:article, created_at: Time.current - 4.days) }
  let!(:test_article5) { create(:article, title: 'Test Article 5', created_at: Time.current - 1.days) }
  describe 'successfully' do
    before do
      get '/api/articles?article_type=story'
    end

    it 'responds with a 200 status' do
      expect(response).to have_http_status 200
    end

    it 'filters out experience article, thus responding with a list of 5 articles' do
      expect(response_json['articles'].length).to eq 5
    end

    it 'responds with newest article first in the list' do
      expect(response_json['articles'].first['title']).to eq 'Test Article 5'
    end

    it 'responds with second newest article second in the list' do
      expect(response_json['articles'].second['title']).to eq 'Test Article 2'
    end

    it 'renders articles with expected teaser' do
      expect(response_json['articles'].first['teaser']).to eq 'MyTeaser'
    end

    it 'renders articles with expected date format' do
      expected_output = (Time.current - 1.days).strftime('%F')
      expect(response_json['articles'].first['date']).to eq expected_output
    end
  end

  describe 'unsuccessfully with no params' do
    before do
      get '/api/articles'
    end

    it 'responds with a 422 status' do
      expect(response).to have_http_status 422
    end

    it 'just responds with all articles' do
      expect(response_json['message']).to eq "Needs specification for type of article!"
    end
  end

  describe 'unsuccessfully with wrong params' do
    before do
      get '/api/articles',
      params: {
        article_type: 'mishmash'
      }
    end

    it 'responds with a 422 status' do
      expect(response).to have_http_status 422
    end

    it 'responds with a error message' do
      expect(response_json['message']).to eq 'Invalid article type. Try story or experience.'
    end

  end
end
