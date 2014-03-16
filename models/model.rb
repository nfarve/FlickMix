class User
  include DataMapper::Resource

  attr_accessor :password, :password_confirmation

  property :id            , Serial
  property :first_name    , String, :required => true
  property :email         , String, :required => true, :unique => true, :format   => :email_address
  property :crypted_password , BCryptHash, :required => true, :writer => :protected
  timestamps :at

  before :valid?, :crypt_password

  validates_presence_of :password, :password_confirmation, :if => :password_required?
  validates_length_of :password, :min => 6 if :password_required?
  validates_confirmation_of :password, :if => :password_required?
 
  def crypt_password
    self.crypted_password = password if password
  end 

  def password_required?
    new? or password
  end
 
  def self.authenticate(email, password)
    user = first(:email => email)
    if user && (user.crypted_password == password)
      user
    else
      nil
    end
  end

end

DataMapper.auto_upgrade!
