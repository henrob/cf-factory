require 'cf_factory/base/cf_inner'

module CfFactory
class CfAppCookieStickinessPolicy
  include CfInner
  
  def initialize(cookie_name, policy_name)
    @cookie_name = cookie_name
    @policy_name = policy_name
  end
      
  def get_cf_attributes
    {"CookieName" => @cookie_name, "PolicyName" => @policy_name}
  end
    
end
end
