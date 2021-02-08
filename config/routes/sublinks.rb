constraints subdomain: /!(www|app|athena)/ do
  get '/new', to: 'public/pushes#index', as: 'pushes'
end