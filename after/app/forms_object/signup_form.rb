class SignupForm
  include ActiveModel::Model

  validates :username, presence: true
  validate  :verify_uniqueness_username
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/ }
  validates :password, length: { minimum: 6 }

  delegate :username, :email, :password , to: :@user

  def initialize
    @user = User.new  
  end

  def user
    @user
  end
  
  def submit?(params)
    @user.attributes = params
    
    if(valid?)
      @user.save!
      true
    else
      false
    end
  end

  def verify_uniqueness_username
    if User.exists? username: username
      errors.add :username, "has already been taken"
    end
  end
end