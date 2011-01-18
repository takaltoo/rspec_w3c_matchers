require File.expand_path(File.dirname(__FILE__) + '/../lib/rspec_w3c_matchers')
require File.expand_path(File.dirname(__FILE__) + '/../spec/responses/responses')
require 'fileutils'


# used for providing fixtures to users of the gem
namespace :fixtures do
  desc 'generate all fixtures for USERS of the GEM'
  task :all => [:valid,:error,:warning]
  
  desc 'generate fixture sample valid response'
  task :valid => :repository do       
    dump W3CValidators::MarkupValidator.new.validate_text(response.valid.html),:valid
  end
  
  desc 'generate fixture sample error response'
  task :error => :repository do   
    dump W3CValidators::MarkupValidator.new.validate_text(response.error.html),:error
  end  

  desc 'generate fixture sample error response'
  task :warning => :repository do       
    dump W3CValidators::MarkupValidator.new.validate_text(response.warning.html),:warning
  end    
  
  desc 'removing all fixture files'
  task :clean do
    files = Dir.glob "#{repo_dir}*.marshal"
    if files.empty?
      puts 'nothing to remove'
    else
      puts "removing files #{files}"
      FileUtils.rm files
    end
  end

  desc 'create directory for Fixtures'
  task :repository do
    repo = repo_dir
    unless File.exists? repo
      puts "generating directory #{repo}"
      FileUtils.mkdir_p repo
    end
  end


  # helper methods for configuration
  def config_dir
    File.expand_path(File.dirname(__FILE__) + '/../')
  end

  def repo_dir
    config_dir + '/spec/fixtures/'
  end

  def dump(data,fname)
    puts "generating file #{fname}"
    file = File.open(repo_dir + fname.to_s + '.marshal','w')
    file.write(Marshal.dump(data))
    file.close
  end
  
  def response
    SampleResponses
  end
  
end
