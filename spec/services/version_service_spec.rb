require 'rails_helper'

RSpec.describe VersionService do

  context 'API response' do
    it 'should contain version data', :vcr do
      VCR.use_cassette('version_service_cassette') do
        expect(version).to be_present
      end
    end
  end

  context "Version's " do
    %w(asin title images features 
     best_seller_rank price inventory).each do |attribute|
      it "#{attribute} attribute should be present", :vcr do
        expect(version[:"#{attribute}"]).to be_present
      end
    end
  end

  def version
    @version ||= version_service.get_version
  end

  def version_service
    @version_service ||= VersionService.new(asin)
  end

  def asin
    "B06WP5P93V"
  end
end

