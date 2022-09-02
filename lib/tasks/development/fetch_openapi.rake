require 'net/http'

namespace :development do
  desc 'githubから最新のopenapiを取得する'
  task :fetch_openapi do
    res = Net::HTTP.get_response URI('https://raw.githubusercontent.com/rahhi555/homeCareNavi_2nd_OpenAPI/master/reference/home-care-navi-second-open-api.yaml')
    new_file = File.open('home-care-navi-second-open-api.yaml', 'w')
    new_file.write(res.body.force_encoding('UTF-8'))
  end
end
