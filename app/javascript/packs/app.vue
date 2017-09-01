<template>
  <div id="app">
    
    <div class="cslogo text-center">
      <img src="img/cslogo.png" width="100px">
    </div>

    <div class="container col-4">
      
      <div class="card">
        <div class="card-header">
          Casual Question App
        </div>
        <div class="card-block">
          
          <!-- USER -->
          <div class="card" style="width: 20rem;">
            <div class="card-block">
              <h4 class="card-title">Stats</h4>
              <p class="card-text">Some amazing stats!</p>
            </div>
            <ul class="list-group list-group-flush">
              <li class="list-group-item">{{totalUsersLbl}}: <span class="badge badge-default">{{totalUsers}}</span></li>
              <li class="list-group-item">{{totalQuestionsLbl}}: <span class="badge badge-default">{{totalQuestions}}</span></li>
              <li class="list-group-item">{{totalAnswersLbl}}: <span class="badge badge-default">{{totalAnswers}}</span></li>
              <li class="list-group-item">{{totalApiRequestsLbl}}: <span class="badge badge-default">{{totalApiRequests}}</span></li>
            </ul>
          </div>
          
        </div>
      </div>

    </div>  
  </div>
</template>

<script>
// Vue Component
export default {

  // Setting default variables
  data: function () {
    return {
      totalUsersLbl: 'Total Users: ',
      totalUsers: 0,

      totalQuestionsLbl: 'Total Questions: ',
      totalQuestions: 0,

      totalAnswersLbl: 'Total Questions: ',
      totalAnswers: 0,

      totalApiRequestsLbl: 'Total API Requests',
      totalApiRequests: 0
    }
  },
  // Method mount is called after page loads 
  mount: function() {
    
    $.getJSON( "ajax/test.json", function( data ) {
      
      
    });
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
