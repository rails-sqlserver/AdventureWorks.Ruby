AdventureWorks::Application.routes.draw do
  
  resources :employees do
    
  end

  root :to => 'employees#index'

end
