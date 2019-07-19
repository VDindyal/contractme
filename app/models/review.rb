class Review < ApplicationRecord
    belongs_to :user, :autosave => true, :dependent => :destroy, :inverse_of => :reviews
    belongs_to :posting, :autosave => true, :dependent => :destroy, :inverse_of => :reviews
end