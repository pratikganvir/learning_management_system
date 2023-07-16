Rails.application.routes.draw do
  
  resources :exam_evaluations
  devise_for :logins
  
  get 'dashboard/home'

  resources :admins do
    collection do
      get 'home'
    end
  end

  resources :schools do
    resources :batches do
      member do
        get 'add_courses'
        patch 'create_courses'
      end

      resources :enrollments do
        member do
          post 'enrollment_verdict'
        end
      end
    end
    resources :courses
    resources :students do
      member do
        get 'enrollments'
        post 'request_enrollment'
        get 'classmates'
      end

      resources :progress_cards
    end
  end

  
  root "dashboard#home"
end
