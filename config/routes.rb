Rails.application.routes.draw do
  mount Sidekiq::Web, at: '/sidekiq'

  resources :users do
    resources :repos do
      resources :contributors do
        collection { get 'poll', to: 'contributors#poll' }
      end

      resources :pull_requests do
        collection { get 'poll', to: 'pull_requests#poll' }
      end

      collection { get 'poll', to: 'repos#poll' }
    end
  end

  get 'webhook', to: 'api/v1/webhooks#github'
end
