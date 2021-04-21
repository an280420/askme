class HashtagQuestion < ApplicationRecord
  # промежуточная модель через которую организуем связь многоие ко многим
  belongs_to :hashtag
  belongs_to :question
end
