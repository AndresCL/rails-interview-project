Rails.application.routes.draw do
  get 'welcome/index'
  
  get 'welcome/home'
  root 'welcome#home'

  get 'api/all'
  get 'api/questions'
  get 'api/stats'

end
