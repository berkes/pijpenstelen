# Project Title

Page that shows rain precipitation in a graph for your current location.

## Getting Started

Ensure you have Ruby (2.x), and bundler installed.

1. `git clone https://github.com/berkes/pijpenstelen`
2. `bundle install`
3. `rackup`

Now visit http://localhost:9292, accept the location request in your
browser and you should see a graph predicting rainfall in next hours.

### Prerequisites

* Ruby 2.x
* bundler >= 1.10
* TODO: find out what header files are required for Rmagic on Ubuntu,
    other Linuxes and OSX.

## Running the tests

Tests are ran on [Travis](https://travis-ci.org/berkes/pijpenstelen)

To run tests locally:

`bundle exec rake`

### Break down into Integration-tests 

Integration tests (also known as end-to-end tests) are found under
`integration`.

These tests run through rack and stub out the external weather provider.
Fixed responses are found in the fixtures directory.

They mimic the experience that an end-user would have.

There is currently no quick way to run only these tests, they are ran as
part of the entire test-suite, so intermixed with the unit-tests.

### And unit tests

Unit tests are found under `models`.

These tests run classes (models) in isolation and test their isolated
behaviour.

There is currently no quick way to run only these tests, they are ran as
part of the entire test-suite, so intermixed with the integration-tests.

### And coding style tests

TODO: houndci

## Deployment

Push to heroku:

1. `heroku login`
2. `heroku ....`
TODO: document all the steps with heroku to deploy from scratch.

## Built With

* [Sinatra](http://sinatrarb.com) - Sinatra micro-framework
* [Gruff](https://github.com/topfunky/gruff) - Graphs for Ruby (using Rmagic)

## Contributing

1. Fork the repository
2. Ensure you agree to the MIT licence
3. Make your changes. Make them small, atomic and focused.
   Ensure the tests are green.
4. Create one (or more) pull-requests. 10 small PRs are better than 1
   big one contain all 10 unrelated changes.
5. Ensure travis and houdci are green.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/your/project/tags). 

## Authors

* **Bèr Kessels** - *Initial work* - [berkes](http://berk.es)

See also the list of [contributors](https://github.com/your/project/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* [RainAlarm-Android](https://github.com/sanderbaas/rainalarm-android)
    by Sanderbaas for a nice app and good inspiration.
* [Buienradar](https://www.buienradar.nl/overbuienradar/gratis-weerdata)
