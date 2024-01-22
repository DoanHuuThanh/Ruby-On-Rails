# frozen_string_literal: true

class DailyreportJob < ApplicationJob
  queue_as :default

  def perform
    report_content = daily_report_job
    send_report_to_slack(report_content)
  end

  def daily_report_job
    users_count = User.new_user_count
    posts_count = Micropost.yesterday_posts.count
    comments_count = Micropost.yesterday_comments
    microposts = most_commented_post

    <<~REPORT
      *Daily Report - #{Date.yesterday.strftime('%Y-%m-%d')}*
      :white_heart: :heart: :white_heart: :heart: :white_heart: :heart:
      *New Users*: #{users_count}
      *New Posts*: #{posts_count}
      *New Comments*: #{comments_count}
      *Most Comments Post*: #{microposts&.map { |micropost| "[#{micropost.content}], (#{ENV['HOST']}/microposts/#{micropost.id})" }}
    REPORT
  end

  def most_commented_post
    post = Micropost.yesterday_posts
    max_count = 0
    micropost_with_max_count = nil

    post.each do |micropost|
      count = micropost.comments.count
      comment = Micropost.where(parent_id: micropost.id)
      count += Micropost.where(parent_id: comment.pluck(:id)).count
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
    client.chat_postMessage(channel: ENV['SLACK_CHANNEL'], text: content, as_user: true)
  end
end
