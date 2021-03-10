RSpec.describe 'PUT /api/admin/articles/:id' ,type: :request do
    let!(:admin) { create(:admin) }
    let!(:article) { create(:article ,admin: admin) }
    let!(:auth_headers) {admin.create_new_auth_token}
    let(:image) do
      {
        type: 'application(png)',
        encoder: 'name=ca_logo.png:base64',
        data: 'AEDAAAAAIEFJEEEEEEEEEMVKAAAAAAAAAAAAAAAOEEFEEEEE',
        extension: 'png'
      }
    end
    describe 'successfully edits article' do
      before do
        put "api/admin/articles/#{article.id}",
        params: {
          title: 'Article title',
          teaser: 'Do you really need this one?',
          body: ['A lot of weird stuffs.'],
          article_type: 'experience',
          category: 'trip',
          location: 'Värnamo',
          image: image
        },
        headers: auth_headers,
        
      end

  end
end