# frozen_string_literal: true

class Interaction < ApplicationRecord
  belongs_to :webhook_event

  validates :service_name, presence: true
  validates :type,         presence: true
  validates :timestamp,    presence: true
  validates :meta_data,    presence: true
end
