RSpec.describe 'POST /api/admin/articles', type: :request do
  let!(:admin) { create(:admin) }
  let!(:auth_headers) {admin.create_new_auth_token}
  describe 'successfully' do
    before do
      post '/api/admin/articles',
           params: {
             title: 'My First Article',
             teaser: 'You better read this, otherwise you will miss out!',
             body: ['A lot of lorem.'],
             article_type: 'story',
             category: 'news',
             location: 'Frederiksdal'
           },
           headers: auth_headers
    end

    it 'responds with a 201' do
      expect(response).to have_http_status 201
    end

    it 'responds with a success message' do
      expect(response_json['message']).to eq 'The article was successfully created.'
    end

    it 'creates a new article in the DB' do
      articles = Article.all
      expect(articles.count).to eq 1
    end

    it 'is expected to belong to the given admin' do
      article = Article.all.first
      expect(article['admin_id']).to eq admin.id
    end

    it 'creates an article with the expected title' do
      article = Article.all.first
      expect(article['title']).to eq 'My First Article'
    end

    it 'creates an article with the expected teaser' do
      article = Article.all.first
      expect(article['teaser']).to eq 'You better read this, otherwise you will miss out!'
    end

    it 'creates an article with the expected body' do
      article = Article.all.first
      expect(article['body']).to eq ['A lot of lorem.']
    end

    it 'creates an article with the expected article_type' do
      article = Article.all.first
      expect(article['article_type']).to eq 'story'
    end

    it 'creates an article with the expected location' do
      article = Article.all.first
      expect(article['location']).to eq 'Frederiksdal'
    end

    it 'creates an article with the expected category' do
      article = Article.all.first
      expect(article['category']).to eq 'news'
    end
  end

  describe 'unsuccessfully for unauthenticated admins' do
    before do
      post '/api/admin/articles',
           params: {
             title: 'My First Article',
             teaser: 'You better read this, otherwise you will miss out!',
             body: 'A lot of lorem.',
             article_type: 'story',
             category: 'news',
             location: 'Frederiksdal'
           }
    end

    it 'responds with a 401' do
      expect(response).to have_http_status 401
    end

    it 'is expected to not create an article' do
      articles = Article.all
      expect(articles.count).to eq 0
    end
  end

  describe 'unsuccessfully if an attribute is missing' do
    before do
      post '/api/admin/articles',
           params: {
             teaser: 'You better read this, otherwise you will miss out!',
             body: 'A lot of lorem.',
             article_type: 'story',
             category: 'news',
             location: 'Frederiksdal'
           },
           headers: auth_headers
    end

    it 'responds with a 422' do
      expect(response).to have_http_status 422
    end

    it 'is expected to not create an article' do
      articles = Article.all
      expect(articles.count).to eq 0
    end

    it 'is expected to return an error message' do
      expect(response_json['message']).to eq 'Please fill out all fields.'
    end
  end
end
