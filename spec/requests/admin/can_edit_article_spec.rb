RSpec.describe 'PUT /api/admin/articles/:id', type: :request do
  let!(:admin) { create(:admin) }
  let!(:article) { create(:article, admin: admin) }
  let!(:auth_headers) {admin.create_new_auth_token}
  let(:image) do
    {
      type: 'application(png)',
      encoder: 'name=ca_logo.png:base64',
      data: 'AEDAAAAAIEFJEEEEEEEEEMVKAAAAAAAAAAAAAAAOEEFEEEEEDSADASDASD',
      extension: 'png'
    }
  end
  describe 'successfully edits article' do
    before do
      put "/api/admin/articles/#{article.id}",
          params: {
            title: 'Article title',
            teaser: 'Do you really need this one?',
            body: ['A lot of weird stuffs.', 'With two paragraphs'],
            article_type: 'experience',
            category: 'trip',
            location: 'Värnamo',
            image: image
          },
          headers: auth_headers
    end

    it 'responds with a 200 status' do
      expect(response).to have_http_status 200
    end

    it 'responds with a success message' do
      expect(response_json['message']).to eq 'The article was successfully updated!'
    end

    it 'expects updated article/s title to be updated' do
      expect(article.reload['title']).to eq 'Article title'
    end

    it 'expects updated article/s article_type to be updated' do
      expect(article.reload['article_type']).to eq 'experience'
    end

    it 'expects updated article/s category to be updated' do
      expect(article.reload['category']).to eq 'trip'
    end
  end

  describe 'unsuccessfully' do
    before do
      put "/api/admin/articles/#{article.id}",
          params: {
            title: '',
            teaser: 'Do you really need this one?',
            body: ['A lot of weird stuffs.', 'With two paragraphs'],
            article_type: 'experience',
            category: 'trip',
            location: 'Frederiksdal',
            image: image
          },
          headers: auth_headers
    end

    it 'responds with 422' do
      expect(response).to have_http_status 422
    end

    it 'responds with not being updated' do
      expect(article.reload.title).to eq 'MyTitle'
    end

    it 'responds with error message' do
      expect(response_json['message']).to eq 'Please fill in all the fields.'
    end
  end
end
