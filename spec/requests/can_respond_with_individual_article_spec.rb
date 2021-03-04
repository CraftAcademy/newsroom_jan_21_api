RSpec.describe 'GET /api/articles/:id', type: :request do
  let!(:test_article1) { create(:article, created_at: Time.local(2021)) }
  describe 'successfully' do
    before do
      get "/api/articles/#{test_article1.id}"
     
    end
    it 'responds with 200 status' do
      expect(response).to have_http_status 200
    end

    it 'responds with the right teaser' do
      expect(response_json['article']['teaser']).to eq 'MyTeaser'
    end

    it 'responds with the right body' do
      expect(response_json['article']['body']).to eq 'MyLongBodyText'
    end

    it 'responds with the right title' do
      expect(response_json['article']['title']).to eq 'MyTitle'
    end

    it 'responds with the right title' do
      expect(response_json['article']['date']).to eq '2020-12-31'
    end
  end


  describe 'unsuccessfully with non-existent article' do
    before do
      get "/api/articles/700"
    end

    it 'responds with 404' do
      expect(response).to have_http_status 404
    end

    it 'responds with right error message' do
      expect(response_json['message']).to eq 'Article not found.'
    end
  end
end