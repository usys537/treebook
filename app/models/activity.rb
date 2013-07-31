class Activity < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :user
  belongs_to :targetable, polymorphic: true


  def user_name
  	user.full_name
  end

  def profile_name
  	user.profile_name
  end

  def as_json(options={})
  	super(
  		only: [:action, :id, :targetable_id, :targetable_type, :created_at, :id],
  		include: :targetable,
  		methods: [:user_name, :profile_name]
  		).merge(options)
  end
end
