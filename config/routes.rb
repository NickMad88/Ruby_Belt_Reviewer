Rails.application.routes.draw do

  resources :users
  resources :events
  resources :sessions
  post '/events/:id/comments' => 'comments#create'
  get '/events/:id/attendee' => 'attendees#create'
  delete '/events/:id/attendee' => 'attendees#destroy'
  get '/' => 'sessions#new'
  get 'users/edit' => 'users#update'
end
