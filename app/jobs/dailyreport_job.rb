# frozen_string_literal: true

class DailyreportJob < ApplicationJob
  queue_as :default

  def perform
    report_content = daily_report_job
    send_report_to_slack(report_content)
  end

  def daily_report_job
    users = User.where(created_at: Date.yesterday.beginning_of_day..Date.yesterday.end_of_day).count
    posts = Micropost.where(created_at: Date.yesterday.beginning_of_day..Date.yesterday.end_of_day, parent_id: nil).count
    comments = Micropost.where(created_at: Date.yesterday.beginning_of_day..Date.yesterday.end_of_day).where.not(parent_id: nil).count
    microposts = most_commented_post

    <<~REPORT
      *Daily Report - #{Date.yesterday.strftime('%Y-%m-%d')}*
      :white_heart: :heart: :white_heart: :heart: :white_heart: :heart:
      *New Users*: #{users}
      *New Posts*: #{posts}
      *New Comments*: #{comments}
      *Most Comments Post*: #{microposts&.map { |micropost| "[#{micropost.content}], (http://127.0.0.1:3000/microposts/#{micropost.id})" }}
    REPORT
  end

  def most_commented_post
    most_commented_post = Micropost.where(created_at: (Date.yesterday - 10.hours)..Date.yesterday.end_of_day, parent_id: nil)
    max_count = 0
    micropost_with_max_count = nil

    most_commented_post.each do |micropost|
      count = micropost.comments.count
      micropost.comments.each do |comment|
        count += comment.comments.count
      end
      micropost_with_max_count << micropost if count == max_count
      if count > max_count
        max_count = count
        micropost_with_max_count = [micropost]
      end
    end

    micropost_with_max_count
  end

  def send_report_to_slack(content)
    client = Slack::Web::Client.new
    client.chat_postMessage(channel: '#it', text: content, as_user: true)
  end
end
