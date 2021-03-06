# frozen_string_literal: true

class Album < ApplicationRecord
  scope :y2019, -> { where(created_at: Time.zone.parse('2019-01-01 00:00:00').all_year) }
  scope :y2020, -> { where(created_at: Time.zone.parse('2020-01-01 00:00:00').all_year) }
end
