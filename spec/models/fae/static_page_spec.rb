require 'rails_helper'

describe Fae::StaticPage do

  describe 'concerns' do
    it 'should allow instance methods through Fae::StaticPageConcern' do
      static_page = FactoryGirl.create(:fae_static_page)

      expect(static_page.instance_says_what).to eq('Fae::StaticPage instance: what?')
    end

    it 'should allow class methods through Fae::StaticPageConcern' do
      expect(Fae::StaticPage.class_says_what).to eq('Fae::StaticPage class: what?')
    end
  end

  describe 'dynamic associations' do

    it 'should attach only once' do
      hp = HomePage.instance
      expect(hp.class.reflect_on_all_associations(:has_one).map(&:name)).to eq([:header, :hero, :email, :introduction, :body, :hero_image, :welcome_pdf])

      # trigger instance twice
      hp = HomePage.instance
      expect(hp.class.reflect_on_all_associations(:has_one).map(&:name)).to eq([:header, :hero, :email, :introduction, :body, :hero_image, :welcome_pdf])
    end

  end

  describe 'dynamic validations' do

    it 'should only attach once' do
      # trigger multiple instances which add dynamic validations to associated objects
      AboutUsPage.instance
      HomePage.instance
      HomePage.instance

      home_page_validations = Fae::TextField.validators_on(:content).keep_if do |v|
        v.options[:if].to_s['is_home_page']
      end
      expect(home_page_validations.map { |v| v.class.name }).to eq(['ActiveRecord::Validations::PresenceValidator', 'ActiveModel::Validations::FormatValidator'])
    end

  end

end