require 'rails_helper'

RSpec.describe Admin, type: :model do
  describe 'validates existence of expected columns' do
    it { is_expected.to have_db_column :role}
  end

  describe 'relationships' do
    it { should have_many(:articles) }
  end

  describe 'validate enum attribute' do
    it { should define_enum_for(:role).with_values([:admin, :editor, :journalist]) }
  end
end
