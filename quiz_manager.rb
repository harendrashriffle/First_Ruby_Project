require "timeout"
require "csv"
require_relative "add_category.rb"

class QuizManager          # Quiz Manager to select & play quiz, view high & all score
  attr_accessor :ctg_scores
  def initialize()
    @ctg_scores = {}       # Categories as Key & their players Name & Scores as Values
  end
    
  def select_quiz(que_add_ctg)                             # to select variety of quiz
    i = 0
    while true
      break if i==3

      ctg_hsh = que_add_ctg.subject_categories        # assign subject_categories hash

      puts "\v#{"-"*12}Select your topic to play quiz:#{"-"*12}\n\n"
      
			ctg_hsh.each_with_index do |(sub_ctg), index|
				puts "#{index+1}). #{sub_ctg.capitalize} MCQ"
			end

      puts "#{ctg_hsh.length()+1}). Exit\n\n"

      puts "Enter the quiz number :"
      category = gets.chomp.to_i                                     # category choose
      puts "\n"

      case category
      
      when 1..(ctg_hsh.length()) 
        ctg_name = ctg_hsh.key(ctg_hsh.values[category-1])
        scores=take_quiz(ctg_hsh.values[category-1])
        
        if @ctg_scores.has_key?(:"#{ctg_name}")          # if category present in hash
          @ctg_scores[:"#{ctg_name}"] << scores       # append name & score in subject
        else
          @ctg_scores[:"#{ctg_name}"] = []          # create ctg as key & arr as value
          @ctg_scores[:"#{ctg_name}"] << scores     # push 1st name & score in new ctg
        end
      
      when ctg_hsh.length()+1
        puts "Exit Successfully"; break
      
      else puts "Invalid Input \n***Select quiz using numerical Value***"; i+=1
      end
    end
  end

  def take_quiz(questions)                         # take question of choosen category
    i=0
    puts "#{"-"*11}Paper start just after Enter your name#{"-"*11}"
    begin                                                         # Exception handling
      return if i==3
      puts "\nEnter your name"
      name = gets.chomp  
      raise if (name.match?(/^[[:alpha:][:blank:]]+$/) == false)
    rescue
      i+=1
      puts "***Enter name only in alphabet***"                      # exception handle
      retry
    end
        
    score=0
    puts "\nPaper Start#{"-"*50}Total Time = #{questions.length()*5}".rjust(20)
    
    questions.each_with_index do |q,index|                   # iterate over ques array
      puts "\n"
      
      puts "\nQ.#{index+1} #{q.ques}" + "Time_Per_Que = 5s".rjust(30)
      q.option.each_with_index do |option, index|       # iterate over options in ques
				puts "\n#{index+1}). #{q.option[index] }"
    	end
      
      puts "\n"
      answer = nil 
      
      begin
        Timeout.timeout(5) do                    # terminate each question after 5 sec
          answer = integer_validation("your answer : ","***Answer by Option No.***"); return if answer.nil?
        end
      rescue Timeout::Error                                     # handle timeout error
      end
      puts ( (answer==q.ans) ? "Correct  Your Score : #{score += 1}" : "incorrect")
    end
    puts "#{name} your total score is : #{score}"
    
    return [name,score.to_i]                          # return array of name and score
  end   

  def view_high_score                                     # display to view high score 
    puts "\n#{"-"*17}All Categories high score:#{"-"*17}"
    @ctg_scores.each do |category, scores_array| 
      puts "#{category.capitalize} : #{display_high_score(scores_array)}" 
    end
  end

  def display_high_score(category)                                # display high score
		return puts"No one has played the game" if category.nil?
    highest_score = 0
    player_name = nil
    category.each do |name,score| 
      if score >= highest_score   
        highest_score = score
        player_name = name        
      end
    end
    return "#{player_name} : #{highest_score}"
  end   

  def view_all_score                                                  # view all score
    puts "\n#{"-"*10}All records of score in all categories :#{"-"*10}"
    @ctg_scores.each do |category,scores|
      puts "#{category.capitalize} : \n#{display_all_score(scores)}"
    end
  end

  def display_all_score(category)                                  # display all score
		return puts"No one has played the game" if category.nil?
    category.map { |name,score| "#{name} : #{score}"}.join("\n")
  end

	def export_data_csv                                        # to export data into CSV
    return puts "\n***CSV has no record***" if @ctg_scores.empty?
		CSV.open("quiz_scores.csv","w") do |csv|
      csv << ["Category","Player Name","Score"]
      @ctg_scores.each do |category,scores|
        scores.each do |name, scores|
          csv << [category.to_s.capitalize, name.to_s, scores.to_s]
        end
      end
      puts "Data Export Successfully"
    end
	end 
end 