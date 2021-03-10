RSpec.describe 'GET /api/admin/articles', type: :request do
  let!(:admin) { create(:admin) }
  let!(:auth_headers) { admin.create_new_auth_token}

  describe 'successfully' do
    let!(:article) {3.times {create(:article, admin: admin)}}
    before do
      Article.all.last.image.attach(io: File.open('storage/seed_image_min.jpg'), filename: 'seed_image.png', content_type: 'image/jpg')
      get '/api/admin/articles',
          headers: auth_headers
    end

    it 'responds with a 200 status' do
      expect(response).to have_http_status 200
    end

    it 'responds with a list of 3 articles' do
      expect(response_json['articles'].count).to eq 3
    end

    it 'expects the articles to belong to the current_admin' do
      expect(response_json['articles'].first['author']['id']).to eq admin.id
    end

    it 'expects the articles to contain the title' do
      expect(response_json['articles'].first['title']).to eq 'MyTitle'
    end

    it 'expects the articles to contain the teaser' do
      expect(response_json['articles'].first['teaser']).to eq 'MyTeaser'
    end

    it 'expects the articles to contain the body' do
      expect(response_json['articles'].first['body']).to eq ['MyLongBodyText']
    end

    it 'expects the articles to contain the article_type' do
      expect(response_json['articles'].first['article_type']).to eq 'story'
    end

    it 'expects the articles to contain the category' do
      expect(response_json['articles'].first['category']).to eq 'event'
    end

    it 'expects the articles to contain the location' do
      expect(response_json['articles'].first['location']).to eq 'Stockholm'
    end

    it 'expects the articles to contain an image url' do
      expect(response_json['articles'].first['image']).to be_truthy
    end
  end

  describe 'unsuccessfully with no belonging articles' do
    before do
      get '/api/admin/articles',
          headers: auth_headers
    end

    it 'responds with a 200 status' do
      expect(response).to have_http_status 200
    end

    it 'responds with a message' do
      expect(response_json['message']).to eq "You haven't written any articles yet."
    end
  end
end
