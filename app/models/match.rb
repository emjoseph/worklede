class Match < ApplicationRecord
  belongs_to :resume, :dependent => :destroy
  has_one :job
end
