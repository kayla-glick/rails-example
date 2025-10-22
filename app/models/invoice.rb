class Invoice < ApplicationRecord
  STATUSES = %w[pending success].freeze
  enum :status, STATUSES.zip(STATUSES).to_h

  has_one_attached :pdf
end
