class PostPublishedJob < ApplicationJob
  queue_as :default

  def perform(post_id)
    post = Post.find(post_id)
    user = post.user
    # Simulate sending email (in real app, use mailer)
    Rails.logger.info "[PostPublishedJob] Email sent to #{user.email} about published post '#{post.title}'"
    # Log notification
    Notification.create!(user: user, post: post, message: "Your post '#{post.title}' was published.")
  end
end 