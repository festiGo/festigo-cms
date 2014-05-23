class Role < ActiveRecord::Base
  NAMES = %w"global_admin curator free_curator"

  belongs_to :authorizable, :polymorphic => true
  belongs_to :user
  attr_accessible :name, :user, :authorizable, :authorizable_id
end
