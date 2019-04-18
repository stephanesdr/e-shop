# frozen_string_literal: true

class CategoryItemController < ApplicationController
  belongs_to :item
  belongs_to :category
end
