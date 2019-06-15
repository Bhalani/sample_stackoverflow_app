module HasFriendlyId
  extend ActiveSupport::Concern

  included do
    extend FriendlyId
    friendly_id :gen_slug, use: [:slugged, :finders]
  end

  private

  def gen_slug
    Array.new(16){ rand(36).to_s(36) }.join
  end
end
