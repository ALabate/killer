class Target < ActiveRecord::Base
  belongs_to :hunter, class_name: "Participant",  foreign_key: "hunter_id"
  belongs_to :pursued, class_name: "Participant", foreign_key: "pursued_id"
  validates :hunter,:pursued, presence: true
  validates :hunter_id, uniqueness: { scope: :pursued_id }
end
