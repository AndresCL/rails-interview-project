class ApiController < BaseApiController

  # questions: Shows all questions, not including private ones.
  def questions
    
    # Generic query param
    @query_param = JSON.parse(params[:qp])

    if @query_param

      # Initializing
      queryKeys = ['private']
      queryVals = ['f']
      querystring = '' 

      # For each query params
      @query_param.each do |item|
        
        key = item['key']
        operator = item['operator']
        value = item['value']

        if operator == 'LIKE'
          value = '\'%' + value + '%\''
        end

        # Building query string
        querystring = key.to_s + ' ' + operator + ' ' + value.to_s
        
      end

      # Get all public questions and include it answers filtering by query string
      # Sample: qp=[{"key":"id","value":1,%20"operator":"="},{"key":"title","value":"VHaS","operator":"LIKE"}]
      @questions = Question.all.where(querystring)

    else
      # Get all public questions and include it answers
      @questions = 
        Question.all
          .where(['questions.private = "f"'])
    end
    
    Rails.logger.info @questions.empty?.to_s

    # Did we find any records
    if @questions.empty?
      # Throw 204 HTTP Status Code: No Content
      head(204)
    else
      # Rendering results as JSON
      render json: @questions.to_json(:include => :answers) 
    end
    
    

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