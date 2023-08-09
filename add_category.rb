require_relative "question.rb"

class AddCategory                # Create class to add category
  attr_accessor :subject_categories
  def initialize()
		@subject_categories = {}     # consist of subject with Question, options and answer
  	
		@subject_categories[:Geography] = [
			Question.new("India has largest deposits of ________ in the world.",["Gold","Copper","Mica","None of the above"],3),
			Question.new("Which of the following lakes in Rajasthan is saline?",["Ana Sagar","Pichola","Sambhar","Jaisamand"],3),
			Question.new("India is the ________ grower of pulses.",["Largest","Smallest","Appropriate for national need","None of the above"],1),
  	]
  
		@subject_categories[:Science] = [
			Question.new("Which of the following gas is reduced in the reduction process?",["Oxygen","Helium","Carbon","Hydrogen"],4),
			Question.new("Which of the following compound is mainly used in hand sanitizer?",["Aldehyde","Acetic acid","Alcohol","Ketone"],3),
			Question.new("Acid turns blue litmus paper into which color?",["Blue","Black","Red","Orange"],3),
		]
  
		@subject_categories[:History] = [
			Question.new("Who was the first President of the United States",["George Washington","Abraham Lincoln","Thomas Jefferson","John F. Kennedy"],1),
			Question.new("The French revolution began in which year",["1789","1776","1812","1914"],1),
			Question.new("The Magna Carta was signed in which country?",["England","France","Germany","Italy"],1),
		]
  
  end

  def select_category               # select category to give quiz
    i=0
    while true
      break if i==3

      puts "\v"
      puts "#{"-"*12}Select your topic to add question:#{"-"*12}\n\n"
      # Provide list of categories
			@subject_categories.each_with_index do |(subject_category), index|
				puts "#{index+1}). #{subject_category.capitalize} MCQ"
			end

			puts "#{@subject_categories.length()+1}). Add your own category"
      puts "#{@subject_categories.length()+2}). Exit"
      puts "\n"

      puts "Kindly choose your topic"
      category = gets.chomp.to_i    # category choose
      puts "\n"

      case category                 # match category
      when 1..(@subject_categories.length())
        add_ques(@subject_categories.values[category-1])
      when @subject_categories.length()+1
        question = []               # array to hold newly added ques
        new_category_name = string_validation("new category name"); return if new_category_name.nil?
        add_ques(question)          # method to add ques
        @subject_categories[:"#{new_category_name}"] = question # assign question,option and answer array to new key as category name
      when @subject_categories.length()+2
        puts "Exit Successfully"
        break
      else puts "Invalid Input\n***Kindly Choose category by categories referece number"; i+=1
      end
    end
  end

  def add_ques(subject_category)    # method to add ques
    ques = string_validation("ques"); return if ques.nil?
    option_1 = string_validation("option 1"); return if option_1.nil?
    option_2 = string_validation("option 2"); return if option_2.nil?
    option_3 = string_validation("option 3"); return if option_3.nil?
    option_4 = string_validation("option 4"); return if option_4.nil?
    ans = integer_validation("ans","***Save Answer by options Numerical references"); return if ans.nil?         
    puts "MCQ added succesfully"
    return subject_category.push(Question.new(ques,[option_1,option_2,option_3,option_4],ans.to_i))   
  end 

  def view_all_ques()     # method to view all ques with category
    puts "\n#{"-"*14}All questions of all categories:#{"-"*14}"
		@subject_categories.each do |subject_category, question|
			puts "\n#{subject_category.upcase} MCQ List"
			puts "#{display_all_ques(question)}"
    end
  end

  def display_all_ques(sub_category_ques)  # display ues and option with serial no.
    sub_category_ques.each_with_index do |q,index|
      puts "\nQ.#{index+1} #{q.ques}"  
			q.option.each_with_index do |option, index|
				puts "\n#{index+1}). #{q.option[index] }"
    	end
		end
	return
	end
end