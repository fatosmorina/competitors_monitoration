require 'rails_helper'
require 'whenever'

describe 'task' do
  it 'makes sure `runner` statements exist' do
    whenever = Whenever::JobList.new(file: Rails.root.join("config", "schedule.rb").to_s)
    expect(whenever).to schedule_rake("versions:retrieve")
      .every(:day)
      .at("12:00 am")
  end
end


