module CfFactory
class CfHelper
  def self.generate_ref(cf_object_ref)
    "{ \"Ref\" : \"#{cf_object_ref}\" }"
  end
  
  def self.generate_att(resource_name, attribute_name)
    "{ \"Fn::GetAtt\" : [ \"#{resource_name}\", \"#{attribute_name}\" ] }"
  end
  
  def self.generate_ref_array(cf_array)
    result = "["
    cf_array.each() {|cf|
      result += "#{cf.generate_ref},"
    }
    result = result.chomp(",")
    result += "]"
    result    
  end
  
  def self.generate_inner_array(cf_array)
    result = "["
    cf_array.each() {|cf|
      result += "#{cf.generate()},"
    }
    result = result.chomp(",")
    result += "]"
    result
  end
  
  def self.generate_inner_list(cf_array)
    result = ""
    cf_array.each() {|cf|
      result += "#{cf.generate},\n"
    }
    result = result.chomp("\n").chomp(",") 
    result
  end
  
  def self.base64(string)
    base = "{ \"Fn::Base64\": \"#{string}\" }"
    return clean(base)
  end
  
  def self.join(array)
    "{ \"Fn::Join\" : [ \"\", #{print_array(array)} ]}"
  end
  
  def self.clean(string)
    string.gsub(/\"{/,"{").gsub(/\"}/,"}").gsub(/}\"/,"}").gsub(/\"\[/,"[").gsub(/\"\]/,"]")#.gsub(/\\/,"") #TODO: the last gsub invalidated line-breaks
  end
  
  def self.availability_zones(string = "")
    "{ \"Fn::GetAZs\" : \"#{string}\" }"
  end

  def self.ref_current_region()
    '{ "Ref" : "AWS::Region" }'
  end
  
  def self.az_in_region(az_id = "a", region = "")
    clean(join([ref_current_region(), az_id]))
  end
  
  def self.az_array_in_region(az_ids = ["b","c"], region = "")
    result = "["
    az_ids.each() {|az_id|
      result += CfHelper.az_in_region(az_id)+", "
    }
    result = result.chomp(" ").chomp(",")
    result += "]"
  end
  
  def self.print_array(array)
    inner = ""
    array.each() {|element|
      if element == "\n"
        inner += "\"\\n\" ,"
      else
        inner += "\"#{element}\" ,"
      end
    }
    inner.chomp!(",")
    result = "[ #{inner} ]"
    #result = array.inspect
    #puts "rsult before CLEAN = #{result}"    
    res = clean(result)
    #puts "rsult after CLEAN = #{res}"
    res
  end
  
end
end
