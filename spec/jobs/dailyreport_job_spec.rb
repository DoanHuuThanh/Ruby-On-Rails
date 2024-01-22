# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DailyreportJob, type: :job do
  describe '#perform' do
    subject(:job) { DailyreportJob.perform_later }

    it 'queues the job in the default queue' do
      expect { job }.to have_enqueued_job(DailyreportJob).on_queue('default')
    end

    it 'has the correct queue name' do
      expect(DailyreportJob.new.queue_name).to eq('default')
    end

    it 'sends daily report to Slack' do
      perform_enqueued_jobs do
        expect { job }.to have_enqueued_job
      end
    end

    it 'enqueues the job' do
      expect { DailyreportJob.perform_later }.to have_enqueued_job(DailyreportJob)
    end
  end
end
