Rails.application.routes.draw do
    devise_for :users, controllers: {
        sessions: 'users/sessions',
        confirmations: 'users/confirmations',
        registrations: 'users/registrations',
        passwords: 'users/passwords'
    }

    resources :postings do
        resources :reviews do

        end
    end

    resources :users do

    end

    root :to => "application#landing"
end
