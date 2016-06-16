# seraph
[![Build Status](https://travis-ci.org/Szeliga/seraph.svg?branch=master)](https://travis-ci.org/Szeliga/seraph)
[![Code Climate](https://codeclimate.com/github/Szeliga/seraph/badges/gpa.svg)](https://codeclimate.com/github/Szeliga/seraph)
[![Test Coverage](https://codeclimate.com/github/Szeliga/seraph/badges/coverage.svg)](https://codeclimate.com/github/Szeliga/seraph/coverage)

A simple framework-agnostic library for authentication. seraph provides an API for implementing User authentication inside your app. It doesn't make any assumptions about your setup, so you do not have to have a `User` class that inherits from `ActiveRecord::Base`.


## Installation

Enter in your terminal
```
gem install seraph
```
or put
``` ruby
gem 'seraph'
```
inside your `Gemfile`

## Configuration

You can set the pepper that will be used when encrypting the password.

Pepper strenghtens the security of your encrypted passwords, because even if you have an SQL Injection vulnerability in your code, the attacker won't be able to get the passwords, because the pepper will be added to each password before encryption. This is ofcourse true only if the attacker doesn't have access to your application code!

To get a random, high-entropy pepper, you can use `/dev/urandom`:

```
xxd -l 32 -p /dev/urandom
```

Then use in the configuration block

``` ruby
Seraph.configure do |config|
  config.pepper = 'GENERATED-PEPPER'
end
```

But remember to save the pepper, because if you lose it, none of your users will be able to login!

## What do you get?

Seraph offers two basic functionalities:

* encrypting the password (registration)
* checking if provided password matches the encrypted password (authentication)

### Encrypting the password

Seraph uses [BCrypt](https://github.com/codahale/bcrypt-ruby) to hash the password. If you configure Seraph and set the pepper, it will be used in the encryption process.

To encrypt a password simply run:

``` ruby
Seraph::PasswordEncryptor.call('foobar12')
# => "$2a$10$f1PWs.Qi3mtcL/fMaypEJu9HI0SchWLhsMd9kRhHEjP4v/3oqnB5G"
```

As a result you get the encrypted password, which you can be persisted in the database, alongside other user data (e-mail, login, etc.)

### Comparing a provided password with the encrypted one

Comparison is done using a constant-time secure comparison method from the gem [fast_secure_compare](https://github.com/daxtens/fast_secure_compare)

To do it simply run:

``` ruby
Seraph::Authenticator.call(encrypted_password, plaintext_password)
# => true or false
```

If the pepper was set in the configuration block, it will be automatically used in the comparison.

## Copyright

Copyright (c) 2016 Szymon Szeliga

See LICENSE.txt for details.
