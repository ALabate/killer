class Target < ActiveRecord::Base

  include AASM
  belongs_to :hunter, class_name: "Participant",  foreign_key: "hunter_id"
  belongs_to :pursued, class_name: "Participant", foreign_key: "pursued_id"
  validates :hunter,:pursued, presence: true
  validates :hunter_id, uniqueness: { scope: :pursued_id }

  #after_create :notify_new_target

  scope :not_killed, -> { where.not(aasm_state: 'killed') }

  aasm do 
    state :healthy, :initial => true
    state :suffering
    state :killed
    state :unreached

    event :kill, after_commit: :notify_kill do
    	 transitions :from => :healthy, :to => :suffering
    end

    event :confirm_kill, after_commit: :changes_after_killed do
    	 transitions :from => [:healthy, :suffering], :to => :killed
    end

    event :deny_kill do
    	 transitions :from => :suffering, :to => :healthy
    end

    event :recognize_as_unreached do
    	 transitions :from => [:healthy, :suffering], :to => :unreached
    end

  end

  def changes_after_killed
    	pursued_target = pursued.target
      pursued_target.recognize_as_unreached!
      # Switch target from the pursued to the hunter
			Target.create(hunter: self.hunter, pursued: pursued_target)
      PlayerMailer.dead_email(self).deliver_now
  end

  def notify_kill
    PlayerMailer.confirm_kill_email(self).deliver_now
  end

  def notify_new_target
    PlayerMailer.new_target_email(self).deliver_now
  end

end
