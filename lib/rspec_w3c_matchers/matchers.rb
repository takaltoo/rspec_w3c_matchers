module RspecW3cMatchers
  
  module InstanceMethods  
    # matcher for detecting zero errors
    def have_no_w3c_errors_in(page)
      RspecW3cMatchers::Notices.new(page,:==,0,:errors)
    end
    
    # matcher for detecting zero warnings
    def have_no_w3c_warnings_in(page)
      RspecW3cMatchers::Notices.new(page,:==,0,:warnings)
    end
    
    # matcher for detecting >0 errors 
    def have_w3c_errors_in(page)
      RspecW3cMatchers::Notices.new(page,:>,0,:errors)
    end
    
    # matcher for detecting >0 errors
    def have_w3c_warnings_in(page)
      RspecW3cMatchers::Notices.new(page,:>,0,:warnings)
    end
    
    
    # matcher for detecting expected number of errors
    def have_specified_number_of_w3c_errors_in(page,number)
      RspecW3cMatchers::Notices.new(page,:==,number,:errors)
    end
    
    # matcher for detecting expected number of warnings
    def have_specified_number_of_w3c_warnings_in(page,number)
      RspecW3cMatchers::Notices.new(page,:==,number,:warnings)
    end
    
    # matcher for detecing > specified number of errors
    def have_more_than_specified_number_of_errors_in(page,number)
      RspecW3cMatchers::Notices.new(page,:>,number,:errors)
    end

    # matcher for detecing > specified number of warnings
    def have_more_than_specified_number_of_warnings_in(page,number)
      RspecW3cMatchers::Notices.new(page,:>,number,:warnings)
    end
    
    # matcher for detecing >= specified number of errors
    def have_greater_than_or_equal_to_specified_number_of_errors_in(page,number)
      RspecW3cMatchers::Notices.new(page,:>=,number,:errors)
    end

    # matcher for detecing >= specified number of warnings
    def have_greater_than_or_equal_to_specified_number_of_warnings_in(page,number)
      RspecW3cMatchers::Notices.new(page,:>=,number,:warnings)
    end
    
    # matcher for detecing < specified number of errors
    def have_less_than_specified_number_of_errors_in(page,number)
      RspecW3cMatchers::Notices.new(page,:<,number,:errors)
    end

    # matcher for detecing < specified number of warnings
    def have_less_than_specified_number_of_warnings_in(page,number)
      RspecW3cMatchers::Notices.new(page,:<,number,:warnings)
    end
    
    # matcher for detecing <= specified number of errors
    def have_less_than_or_equal_to_specified_number_of_errors_in(page,number)
      RspecW3cMatchers::Notices.new(page,:<=,number,:errors)
    end

    # matcher for detecing <= specified number of warnings
    def have_less_than_or_equal_to_specified_number_of_warnings_in(page,number)
      RspecW3cMatchers::Notices.new(page,:<=,number,:warnings)
    end
    
  end

end

include RspecW3cMatchers::InstanceMethods