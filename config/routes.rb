Rails.application.routes.draw do
  get 'noz_stats/index' => 'noz_stats#index'
  get 'noz_stats/table' => 'noz_stats#table'
  
  get 'noz_stats/show' => 'noz_stats#show'
  
end
