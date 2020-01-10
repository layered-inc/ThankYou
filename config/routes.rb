# == Route Map
#
#                        Prefix Verb     URI Pattern                                                                              Controller#Action
#                   rails_admin          /admin                                                                                   RailsAdmin::Engine
#              new_user_session GET      /users/sign_in(.:format)                                                                 devise/sessions#new
#                  user_session POST     /users/sign_in(.:format)                                                                 devise/sessions#create
#          destroy_user_session DELETE   /users/sign_out(.:format)                                                                devise/sessions#destroy
# user_slack_omniauth_authorize GET|POST /users/auth/slack(.:format)                                                              users/omniauth_callbacks#passthru
#  user_slack_omniauth_callback GET|POST /users/auth/slack/callback(.:format)                                                     users/omniauth_callbacks#slack
#      cancel_user_registration GET      /users/cancel(.:format)                                                                  registrations#cancel
#         new_user_registration GET      /users/sign_up(.:format)                                                                 registrations#new
#        edit_user_registration GET      /users/edit(.:format)                                                                    registrations#edit
#             user_registration PATCH    /users(.:format)                                                                         registrations#update
#                               PUT      /users(.:format)                                                                         registrations#update
#                               DELETE   /users(.:format)                                                                         registrations#destroy
#                               POST     /users(.:format)                                                                         registrations#create
#                          root GET      /                                                                                        messages#index
#     personality_insights_user GET      /users/:id/personality_insights(.:format)                                                users#personality_insights
#               dashboards_user GET      /users/:id/dashboards(.:format)                                                          users#dashboards
#                         users GET      /users(.:format)                                                                         users#index
#                               POST     /users(.:format)                                                                         users#create
#                      new_user GET      /users/new(.:format)                                                                     users#new
#                     edit_user GET      /users/:id/edit(.:format)                                                                users#edit
#                          user GET      /users/:id(.:format)                                                                     users#show
#                               PATCH    /users/:id(.:format)                                                                     users#update
#                               PUT      /users/:id(.:format)                                                                     users#update
#                               DELETE   /users/:id(.:format)                                                                     users#destroy
#               search_messages GET      /messages/search(.:format)                                                               messages#search
#                      messages GET      /messages(.:format)                                                                      messages#index
#                               POST     /messages(.:format)                                                                      messages#create
#                   new_message GET      /messages/new(.:format)                                                                  messages#new
#                  edit_message GET      /messages/:id/edit(.:format)                                                             messages#edit
#                       message GET      /messages/:id(.:format)                                                                  messages#show
#                               PATCH    /messages/:id(.:format)                                                                  messages#update
#                               PUT      /messages/:id(.:format)                                                                  messages#update
#                               DELETE   /messages/:id(.:format)                                                                  messages#destroy
#                         likes POST     /likes(.:format)                                                                         likes#create
#                          like DELETE   /likes/:id(.:format)                                                                     likes#destroy
#                                        /cable                                                                                   #<ActionCable::Server::Base:0x00007fc7f7ca3bb0 @mutex=#<Monitor:0x00007fc7f7ca3b88 @mon_owner=nil, @mon_count=0, @mon_mutex=#<Thread::Mutex:0x00007fc7f7ca3b38>>, @pubsub=nil, @worker_pool=nil, @event_loop=nil, @remote_connections=nil>
#            rails_service_blob GET      /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
#     rails_blob_representation GET      /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
#            rails_disk_service GET      /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
#     update_rails_disk_service PUT      /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
#          rails_direct_uploads POST     /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create
#
# Routes for RailsAdmin::Engine:
#   dashboard GET         /                                      rails_admin/main#dashboard
#       index GET|POST    /:model_name(.:format)                 rails_admin/main#index
#         new GET|POST    /:model_name/new(.:format)             rails_admin/main#new
#      export GET|POST    /:model_name/export(.:format)          rails_admin/main#export
# bulk_delete POST|DELETE /:model_name/bulk_delete(.:format)     rails_admin/main#bulk_delete
# bulk_action POST        /:model_name/bulk_action(.:format)     rails_admin/main#bulk_action
#        show GET         /:model_name/:id(.:format)             rails_admin/main#show
#        edit GET|PUT     /:model_name/:id/edit(.:format)        rails_admin/main#edit
#      delete GET|DELETE  /:model_name/:id/delete(.:format)      rails_admin/main#delete
# show_in_app GET         /:model_name/:id/show_in_app(.:format) rails_admin/main#show_in_app

Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'registrations' }

  root to: 'messages#index'
  # devise_scope :user do
  #   root to: "devise/sessions#new"
  # end

  resources :users do
    member do
      get :personality_insights
      get :dashboards
    end
  end

  resources :messages do
    collection do
      get :search
      # get :full_text
      # get :message_cloud
    end
  end

  resources :likes, only: %i[create destroy]

  mount ActionCable.server => '/cable'
end
