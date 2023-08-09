require_relative "quiz_manager.rb"       # calling quiz class
require_relative "add_category.rb"		 # calling add category class
require_relative "validations.rb"		 # calling 
include Validation

class QuizInterface                      # Option UI
	def ui
		que_select = QuizManager.new
		que_add_ctg = AddCategory.new
		i=0
		while true  
			break if i==3                     
			puts "\n#{"-"*20}Welcome to Quiz Game#{"-"*20}\n\n" 
			puts "1). Select Quiz"
			puts "2). View High Score"
			puts "3). Create quiz"
			puts "4). View All score"
			puts "5). View All ques"
			puts "6). Export Player Name and Score"
			puts "7). Exit"
			puts "\n"
			puts "Enter your choice"
			choice = gets.chomp.to_i
				
			case choice
			when 1 then que_select.select_quiz(que_add_ctg)
			when 2 then que_select.view_high_score()
			when 3 then que_add_ctg.select_category()
			when 4 then que_select.view_all_score() 
			when 5 then que_add_ctg.view_all_ques()
			when 6 then que_select.export_data_csv()
			when 7 then puts "Exit Successfully"; break
			else puts "Invalid Input \n ***Kindly choose by options Numerical Reference value";i+=1;
			end
		end
	end
end

user = QuizInterface.new
user.ui