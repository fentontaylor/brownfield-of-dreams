# Brownfield Of Dreams

### About the Project
This project was a Turing Backend Mod 3 group project where we practiced:
- JSON API consumption
- OAuth authentication
- self-referential relationships
- Building on top of brownfield code
- Empathy for developers facing deadlines
- Empathy for future devs and our future selves
- Prioritization on a tight deadline

We built on an [existing code base](https://github.com/turingschool-examples/brownfield-of-dreams) with user stories outlined within the following Github Project: https://github.com/turingschool-examples/brownfield-of-dreams/projects/1

The code base we inherited is a Ruby on Rails application used to organize YouTube content used for online learning. Each tutorial is a playlist of video segments. Within the application an admin is able to create tags for each tutorial in the database. A visitor or registered user can then filter tutorials based on these tags.

A visitor is able to see all of the content on the application but in order to bookmark a segment they will need to register. Once registered a user can bookmark any of the segments in a tutorial page.

Brownfield Of Dreams is brought to you by:
- [Nancy Lee](https://alumni.turing.io/alumni/nancy-lee)
- [Fenton Taylor](https://alumni.turing.io/alumni/fenton-taylor)
- [Nathan Thomas](https://alumni.turing.io/alumni/nathan-thomas)

Check out the Brownfield Of Dreams repo [HERE](https://github.com/fentontaylor/brownfield-of-dreams)

Interact with Brownfield Of Dreams on Heroku [HERE](https://brownfielddreams.herokuapp.com)

# Built Using
* Ruby 2.4.1
* Rails5.2.0
* GitHub and YouTube APIs
* PostgreSQL database
* Javascript
* Stimulus
* will_paginate
* webpacker
* vcr
* webmock
* selenium-webdriver
* chromedriver-helper

# Run Brownfield of Dreams on your local machine
1. `$ git clone https://github.com/fentontaylor/brownfield-of-dreams`
2. `$ bundle install`
3. `$ bundle exec figaro install` -- add your API keys to config/application.yml:

```
YOUTUBE_API_KEY: "<your YouTube API key>"
GITHUB_API_KEY: "<your GitHub API key>"
GITHUB_CLIENT_ID: "<your GitHub client_id>"
GITHUB_CLIENT_SECRET: "<your GitHub client_secret>"

```
4. Install node packages for stimulus
```
$ brew install node
$ brew install yarn
$ yarn add stimulus
```
5. `$ bundle exec rspec install`
6. `$ rails db:{create,migrate,seed}`
7. You can run test suite with `$ bundle exec rspec`
8. Start a local server with `$ rails s` and access Brownfield of Dreams in your browser at localhost:3000
