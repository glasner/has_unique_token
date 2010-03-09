module HasUniqueToken
  
  def self.included(base)
    base.extend(ClassMethods)
    base.class_eval do
      before_create :set_token, :unless => :token?
    end
  end
  
  #= Class methods
  module ClassMethods
   
    # returns unique hex token
    def token
      generated = ActiveSupport::SecureRandom.hex.downcase 
      exists?(:token => generated) ? self.token : generated
    end
    
    # returns true if app exists for given token
    def valid_token?(token)
      exists?(:token => token)
    end 
   
  end
 
  #= Instance methods
  
  def set_token
    self.token = self.class.token
  end
  
end







