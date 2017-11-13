Rails.application.routes.draw do
  get 'new',    to: 'words#game'
  post 'score', to: 'words#score'
  root to: 'words#game'
end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
