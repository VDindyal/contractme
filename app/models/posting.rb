class Posting < ApplicationRecord
    belongs_to :user, :autosave => true, :dependent => :destroy, :inverse_of => :postings
end