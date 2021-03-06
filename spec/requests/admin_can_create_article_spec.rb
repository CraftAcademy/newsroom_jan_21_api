RSpec.describe 'POST /api/articles', type: :request do
  describe 'successfully' do
    before do
      post '/api/articles',
      params: {
        title: 'My First Article',
        teaser: 'You better read this, otherwise you will miss out!',
        body: 'A lot of lorem.',
        article_type: 'story',
        category: 'news',
        location: 'Frederiksdal'
      }
    end

    it 'responds with a 201' do
      expect(response).to have_http_status 201
    end

    it 'responds with a success message' do
      expect(response_json['message']).to eq 'The article was successfully created.'
    end

    it 'creates a new article in the DB' do
      binding.pry
      articles = Article.all
      expect(articles.count).to eq 1
    end
  end
end