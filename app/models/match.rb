class Match < ApplicationRecord
  belongs_to :resume
  has_one :job, :dependent => :destroy
end
