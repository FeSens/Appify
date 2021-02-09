constraints subdomain: /(?!www|app|athena)(\S{3,30})/ do
  get '/new', to: 'public/pushes#new', as: 'pushes'
end