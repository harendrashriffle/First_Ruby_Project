class Question                  #  to add question
  attr_accessor :ques, :option, :ans
  def initialize(ques,option,ans)
    @ques = ques
    @option = option
    @ans = ans
  end 
end