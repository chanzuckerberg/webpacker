namespace :webpacker do
  desc "Support for older Rails versions. Install all JavaScript dependencies as specified via Yarn"
  task :npm_install do
    system 'npm install'
  end
end
