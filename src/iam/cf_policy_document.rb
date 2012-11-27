require 'base/cf_inner'

class CfPolicyDocument
  include CfInner
    
  def initialize(statements, additional_indent = 2)
    @additional_indent = additional_indent
    @statements = statements
  end
  
  def get_cf_attributes()
    {"Statement" => CfHelper.generate_inner_array(@statements)} 
  end
  
  def additional_indent
    @additional_indent
  end  
  
end