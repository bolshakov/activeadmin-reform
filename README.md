# ActiveAdmin Reform

This gem adds integration between ActiveAdmin and [Reform](https://github.com/apotonick/reform). So you may 
 use form objects for your forms. 

The purpose of this gem is to provide ability to define custom ActiveAdmin-specific validations for 
your models. Using form objects allows you to define such validations without cluttering model's code
and simplifies building test objects.
 
## Installation

Add this line to your application's Gemfile:

```ruby
gem 'activeadmin_reform'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install activeadmin_reform

## Usage

Define your from object
 
```ruby
require 'reform'

class AuthorForm < Reform::Form
  property :last_name, validates: { presence: true }
  property :name
end
```

Specify form class for ActiveAdmin resource:

```ruby
ActiveAdmin.resource Author do
  form_class AuthorForm
  
  form do |f|
    f.semantic_errors(*f.object.errors.keys)

    f.inputs do
      f.input :name
      f.input :last_name
    end

    f.actions
  end
end
```

Now ActiveAdmin will use Reform form object to validate form. 
Note, you must explicitly define form for resource.

By default ActiveAdmin will not use Reform, but if you want to reopen resource and
disable form object usage, pass `false` instead of class:

```ruby
ActiveAdmin.resource Author do
  form_class false
end
```

## Contributing

The [contributing guide](CONTRIBUTING.md) is a good place to start.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

