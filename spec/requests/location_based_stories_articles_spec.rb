RSpec.describe 'GET api/articles', type: :request do
  let!(:article_other_location) {3.times { create(:article) }}

  describe 'successfully' do
    let!(:article) { 2.times { create(:article, title: "From Frederiksdal", location: 'Frederiksdal')} }
    before do
      get '/api/articles?article_type=story&lat=55.7842432&long=12.45184'
    end

    it 'responds with a 200 status' do
      expect(response).to have_http_status 200
    end

    it 'responds with expected list of articles' do
      expect(response_json['articles'].count).to eq 2
    end

    it 'articles have expected location' do
      expect(response_json['articles'].first['title']).to eq 'From Frederiksdal'
    end

    it 'responds with the location' do
      expect(response_json['location']).to eq 'Frederiksdal'
    end
  end
  describe 'unsuccessfully, but renders instead all stories' do
    before do
      get '/api/articles?article_type=story&lat=55.7842432&long=12.45184'
    end

    it 'responds with a 200 status' do
      expect(response).to have_http_status 200
    end

    it 'responds with expected list of articles' do
      expect(response_json['articles'].count).to eq 3
    end

    it 'responds with a message' do
      expect(response_json['message']).to eq 'We found no local articles from Frederiksdal.'
    end

    it 'is being serialized correctly' do
      expect(response_json['articles'].first['date']).to be_truthy
    end
  end

  describe 'unsuccessfully if lat & long values was never given' do
    before do
      get '/api/articles?article_type=story&lat=&long='
    end

    it 'responds with a 200 status' do
      expect(response).to have_http_status 200
    end

    it 'responds with expected list of articles' do
      expect(response_json['articles'].count).to eq 3
    end

    it 'responds with a message' do
      expect(response_json['message']).to eq "We weren't able to get your location. Enjoy our latest articles instead!"
    end

    it 'is being serialized correctly' do
      expect(response_json['articles'].first['date']).to be_truthy
    end
  end
end
