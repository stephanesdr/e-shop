# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def created_at_french
    year = format('%02d', created_at.year)
    month = format('%02d', created_at.month)
    day = format('%02d', created_at.day)
    time = created_at.strftime("%Hh%M")
    "#{day}/#{month}/#{year.to_s[2..3]} - #{time}"
  end

  def updated_at_french
    year = format('%02d', updated_at.year)
    month = format('%02d', updated_at.month)
    day = format('%02d', updated_at.day)
    time = updated_at.strftime("%Hh%M")
    "#{day}/#{month}/#{year.to_s[2..3]} - #{time}"
  end
end
