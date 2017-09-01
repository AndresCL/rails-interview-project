class ApiController < BaseApiController

  # questions: Shows all questions, not including private ones.
  def questions
    
    # Generic query param
    if params.has_key?(:q)
      @query_param = JSON.parse(params[:q])
    end

    if @query_param

      # Initializing
      queryKeys = []
      queryVals = []
      querystring = 'private = \'f\'' 

      # For each query params
      @query_param.each do |item|
        
        key = item['key']
        operator = item['operator']
        value = item['value']

        if operator == 'LIKE'
          value = '\'%' + value.to_s + '%\''
        elsif operator == '='
          value = '\'' + value.to_s + '\''
        else
          value = '\'' + value.to_s + '\''
        end
        
        # Building query string (only if it is different than private, we don't want to show that questions)
        if key != 'private'
          querystring.concat ' and ' + key.to_s + ' ' + operator + ' ' + value.to_s
        end
        
      end

      Rails.logger.info 'pqs: ' + querystring
      # Get all public questions and include it answers filtering by query string
      # Sample: qp=[{"key":"id","value":2,"operator":"="},{"key":"title","value":"eth","operator":"LIKE"}]
      @questions = Question.all.where(querystring)
      
    else
      # Get all public questions and include it answers
      @questions = 
        Question.all
          .where(['questions.private = "f"'])
    end

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