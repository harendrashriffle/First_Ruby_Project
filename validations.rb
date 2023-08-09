module Validation
  def string_validation(str)
    for i in 1..3
      puts "Enter #{str}"
      string = gets.chomp.strip
      if string.empty? 
        puts "***Kindly enter #{str}***\n"
        if (i==3)
          break
        end
      else
        return string
      end
    end
  end

  def integer_validation(integer,error_message)
    puts "Enter #{integer}"
    i=0
    begin
      return if i==3
      ans =Integer(gets.chomp)
    rescue
      i+=1
      puts error_message
      retry
    end    
    return ans
  end
end