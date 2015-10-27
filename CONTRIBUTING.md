After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. 
You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. 
To release a new version, update the version number in `activeadmin-reform.gemspec`, and then 
run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, 
and push the `.gem` file to [rubygems.org](https://rubygems.org).

If you need to test against specific rails version run `RAILS_VERSION=4.1.19 rake setup`.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Prepare tests infrastructure (`RAILS_ENV=test bundle exec rake setup`)
4. Make your changes and runs specs (`bundle exec rake`)
5. Make sure your code stylish enough  (`bundle exec rubocop`)
6. Commit your changes (git commit -am 'Add some feature')
7. Push to the branch (git push origin my-new-feature)
8. Create Pull Request
