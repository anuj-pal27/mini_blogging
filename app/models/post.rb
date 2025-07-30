class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy
  before_validation :generate_slug

  validates :title, :body, :status, presence: true
  validates :slug, uniqueness: true
  validates :user, presence: true

  after_update :enqueue_publish_job, if: :just_published?

  def to_param
    slug
  end

  private

  def generate_slug
    if title.present?
      self.slug = title.parameterize
    end
  end

  def just_published?
    saved_change_to_status? && status == 'published'
  end

  def enqueue_publish_job
    PostPublishedJob.perform_later(self.id)
  end
end
