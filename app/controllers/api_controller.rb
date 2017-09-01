class ApiController < BaseApiController

  # questions: Shows all questions, not including private ones.
  def questions
    # Get all public questions and include it answers
    @questions = Question.all.where(['questions.private = "f"']).to_json(:include => :answers) 
    
    # Rendering results as JSON
    render json: @questions
  end

  # stats: Return app stats
  def stats

    # Get user count
    u = User.select('COUNT(users.id) AS ttu').first

    # Get questions count
    q = Question.select('COUNT(questions.id) AS ttq').first

    # Get answers count
    a = Answer.select('COUNT(answers.id) AS tta').first

    # Get answers count
    r = Tenantsrequest.select('COUNT(tenantsrequests.id) AS ttr').first

    # Rendering results as JSON
    render json: 
      '{ "u": "' + u.ttu.to_json + '", ' +
        '"q":"' + q.ttq.to_json + '", ' +
        '"a":"' + a.tta.to_json + '", ' +
        '"r":"' + r.ttr.to_json + '"}'

  end

 end