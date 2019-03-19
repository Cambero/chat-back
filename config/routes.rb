Rails.application.routes.draw do
  defaults format: :json do
    resources :rooms, only: %i[index show create]
  end
end
