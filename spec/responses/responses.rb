[ 
  'error',
  'warning',    
  'valid'
].each do |file|
  require File.expand_path(File.dirname(__FILE__)) + '/' + file
end



module SampleResponses

  def self.load(name)    
    file = File.open(self.file(name),'r')
    data = Marshal.load(file)
    file.close
    return data
  end
  
  def self.warning
    SampleResponses::Warning
  end
  def self.error
    SampleResponses::Error
  end
  def self.valid    
    SampleResponses::Valid
  end
  
  private
  
  def self.path
    File.expand_path(File.dirname(__FILE__) + '/../' + 'fixtures/') 
  end
  
  def self.file(name)
    self.path + '/' + name.to_s + ".marshal"
  end
  
end