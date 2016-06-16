# seraph
[![Build Status](https://travis-ci.org/Szeliga/seraph.svg?branch=master)](https://travis-ci.org/Szeliga/seraph)

A simple framework-agnostic library for authentication. seraph provides an API for implementing User authentication inside your app. It doesn't make any assumptions about your setup, so you do not have to have a `User` class that inherits from `ActiveRecord::Base`.


## Installation

Enter in your terminal
```
gem install seraph
```
or put
```
gem 'seraph'
```
inside your `Gemfile`

### What do you get?

seraph offers two basic functionalities:

* encrypting the password (registration)
* checking if provided password matches the encrypted password (authentication)

#### Encrypting the password

seraph uses [BCrypt](https://github.com/codahale/bcrypt-ruby) to hash the password. Additionally a pepper can be provided:

To get a random, high-entropy pepper, you can use `/dev/urandom`:

```
⇒ xxd -l 32 -p /dev/urandom
435a501746f35834862e49fd6654680803bc37a2a83bc67318342603b7176aaa
```

Save this value as a constant in you application code, so even if you have an SQL Injection vulnerability in your code, the attacker won't be able to get the passwords, because the pepper will be added to each password without encryption. This is of course true only if the attacker doesn't have access to your application code!

So with that out of the way, to encrypt a password, run the following code:

``` ruby
PEPPER = '435a501746f35834862e49fd6654680803bc37a2a83bc67318342603b7176aaa'
seraph::PasswordEncryptor.call('foobar12')
# => "$2a$10$MvzzJOcgCbxmVAUqwq7Zye.3Hn9L0ahB4M8riQTK6cPUfJCR6x3ZW"
```

As a result you get the encrypted password, which you can persist in the database alongside other user data (e-mail, login, etc.)

#### Comparing a provided password with the encrypted one

Comparison is done using a constant-time secure comparison method, from the gem (fast_secure_compare)[https://github.com/daxtens/fast_secure_compare]

To do it simply run:

``` ruby
PEPPER = '435a501746f35834862e49fd6654680803bc37a2a83bc67318342603b7176aaa'
seraph::Authenticator.call(encrypted_password, plaintext_password)
# => true or false
```

## Copyright

Copyright (c) 2016 Szymon Szeliga

See LICENSE.txt for details.
