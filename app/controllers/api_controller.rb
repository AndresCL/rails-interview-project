class ApiController < BaseApiController
  
  # all: Shows all questions, including private ones.
  def all
    render json: Question.all
  end

  # find: Shows all questions, not including private ones.
  def questions
    # Get all public questions and include it answers
    @questions = Question.all.where(['questions.private = "f"']).to_json(:include => :answers) 
    render json: @questions
  end
 end