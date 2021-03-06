![KILLER Banner](http://cl.ly/image/3u1E1y3Z432L/Screen%20Shot%202015-04-22%20at%2022.43.39.png)

__Master__ [![Build Status](https://magnum.travis-ci.com/supertinou/killer.svg?token=qc3AoUDpTfCVuzP4GvZq&branch=master)](https://magnum.travis-ci.com/supertinou/killer)
__Develop__ [![Build Status](https://magnum.travis-ci.com/supertinou/killer.svg?token=qc3AoUDpTfCVuzP4GvZq&branch=develop)](https://magnum.travis-ci.com/supertinou/killer)

## Getting Started

After you have cloned this repo, run this setup script to set up your machine
with the necessary dependencies to run and test this app:

    % ./bin/setup

It assumes you have a machine equipped with Ruby, Postgres, etc. If not, set up
your machine with [this script].

[this script]: https://github.com/thoughtbot/laptop

After setting up, you can run the application using [foreman]:

    % foreman start

If you don't have `foreman`, see [Foreman's install instructions][foreman]. It
is [purposefully excluded from the project's `Gemfile`][exclude].

[foreman]: https://github.com/ddollar/foreman
[exclude]: https://github.com/ddollar/foreman/pull/437#issuecomment-41110407

## Guidelines

Use the following guides for getting things done, programming well, and
programming in style.

* [Protocol](http://github.com/thoughtbot/guides/blob/master/protocol)
* [Best Practices](http://github.com/thoughtbot/guides/blob/master/best-practices)
* [Style](http://github.com/thoughtbot/guides/blob/master/style)

## Deploying

If you have previously run the `./bin/setup` script,
you can deploy to staging and production with:

    $ ./bin/deploy staging
    $ ./bin/deploy production
