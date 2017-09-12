require 'rails_helper'
require 'whenever'

describe 'makes sure' do
  it 'version:retrieve is executed everyday at midnight' do
    whenever = Whenever::JobList.new(file: Rails.root.join("config", "schedule.rb").to_s)
    expect(whenever).to schedule_rake("versions:retrieve")
      .every(:day)
      .at("12:00 am")
  end

  it 'notifications:create is executed at midnight' do
    whenever = Whenever::JobList.new(file: Rails.root.join("config", "schedule.rb").to_s)
    expect(whenever).to schedule_rake("notifications:create")
      .every(:day)
      .at("10:00 am")
  end

end


