After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake` to run the tests.
You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a
new version, update the version number in `version.rb`, and then run `bundle exec rake release`,
which will create a git tag for the version, push git commits and tags, and push the `.gem`
file to [rubygems.org](https://rubygems.org).


We test this gem against different versions of `ActiveRecord` using [appraisal](https://github.com/thoughtbot/appraisal) gem.
To regenerate gemfiles run:

    $ appraisal install

To run specs against all versions:

    $ appraisal rake spec
