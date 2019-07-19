class Posting < ApplicationRecord
    belongs_to :user, :autosave => true, :dependent => :destroy, :inverse_of => :postings
    has_many :reviews, :inverse_of => :posting
end