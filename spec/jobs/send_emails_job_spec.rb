require 'rails_helper'

RSpec.describe SendEmailsJob, type: :job do
  it "matches with enqueued job" do
    ActiveJob::Base.queue_adapter = :test
    expect {
      SendEmailsJob.perform_later
    }.to have_enqueued_job(SendEmailsJob)
  end
end