Rails.application.routes.draw do
  defaults format: :json do
    resources :rooms, only: %i[index show create] do
      resources :messages, only: :create
    end
  end
end
