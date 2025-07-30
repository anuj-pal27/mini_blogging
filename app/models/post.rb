class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  before_validation :generate_slug

  validates :title, :body, :status, presence: true
  validates :slug, uniqueness: true
  validates :user, presence: true

  def to_param
    slug
  end

  private

  def generate_slug
    if title.present?
      self.slug = title.parameterize
    end
  end
end
