require 'rails_helper'

RSpec.describe Article, type: :model do
  describe 'validates attributes' do
    it { should validate_presence_of(:article_type)}
    it { should validate_presence_of(:title)}
    it { should validate_presence_of(:teaser)}
    it { should validate_presence_of(:body)}
  end

  describe 'validate enum attribute' do
    it { should define_enum_for(:article_type).with_values([:experience, :story]) }
  end
end
