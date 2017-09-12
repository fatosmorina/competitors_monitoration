require 'rails_helper'
RSpec.describe VersionWorker, type: :worker do

  it { is_expected.to be_processed_in :default }

  it 'should be retryable' do
    expect(VersionWorker).to be_retryable true
  end

end
