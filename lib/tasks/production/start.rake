namespace :production do
  desc '本番環境開始'
  task start: :environment do
    sh 'rails db:create'
    sh 'rails db:migrate'
    sh "rails s -b '0.0.0.0'"
  end
end
