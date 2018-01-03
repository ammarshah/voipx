class NotifiedMatch < ApplicationRecord
    belongs_to :user
    belongs_to :route
    belongs_to :match, class_name: 'Route'
end