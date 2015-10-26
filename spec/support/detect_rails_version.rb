def detect_rails_version
  rails_version = ENV['RAILS_VERSION'] || 'default'
  case rails_version
  when 'master'
    { github: 'rails/rails' }
  when 'default'
    '>= 4.0.0'
  else
    "~> #{rails_version}"
  end
end
