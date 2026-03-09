Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "appointments/:id", to: "appointments#show"
    end
  end
end
