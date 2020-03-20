# Coronavirus Testing Management Platform

If you need help setting this platform up, please email me at brandon.cummings@berkeley.edu, we are more than happy to help set this up for any city.

-Brandon

## Introduction

This platform was created for local cities or municipalities to help manage corona virus testing sites.
This platform accomplishes 3 main goals:

#### Questionnaire to self diagnose symptoms

If symptoms are present, the user will be shown a map that shows all local testing sites, and a google map link to direct them to the site.

#### Testing site management

For all testing sites, there is a portal to keep track of number of tests administered and number of patients in line.

#### Admin management

Full admin suite to create/edit testing site officials, testing sites, and a dashboard for analytics to gain real time insights.

#### Proving the value of more testing centers:

Some local cities will not immediately see the need for more public testing centers and will need a digestible way of analyzing this solution.
To aide with that, we created a [slide deck to explain why cities should implement this platform][deck].

## Hosting and Deploying

Please see the [self hosting guide](docs/self-hosting.md).

## 🏎 Getting up and Running

Because installing dependencies is such a pain, we've bootstrapped this thing for you!

```bash
bin/setup

# for all options:

bin/setup -h
```

being sure to follow any instructions it gives you.
After you've done that you should have:

* the following soft dependencies installed: PostgreSQL, Heroku Toolbelt, etc...
* the correct version of Ruby installed and activated
* hard dependencies (via `Gemfile`) installed
* a local `.env` file for setting ENV Vars
* databases created w/schemas loaded for both `development` and `test` environments.
* seed `development` databases

#### 🗂 ENV Vars

You can set some *optional* [ENV Vars][env-vars] to tweak the way the app runs, or simulate the app running on other platforms.
In development and test, you should configure these via a [`.env` file][dotenv].

  - `DATABASE_URL`: set to mimic the behavior of setting the database connection on Heroku. *(Default to using `config/database.yml`)*
  - `DB_REAPING_FREQUENCY`: how often (in seconds) the database connection pool should be reaped. _(Default = `10`)_
  - `WEB_CONCURRENCY`: set the number of [Puma][puma] worker process to run. *(Default = `2`)*
  - `RAILS_MAX_THREADS`: set the number of [Puma][puma] threads & ActiveRecord's connection pool size. *(Default = `5`)*

There are also some **required** [ENV Vars][env-vars] that you'll need to set for all environments.

  - `GOOGLE_API_KEY`: the API key used to render Google Maps.
  - `RECAPTCHA_SECRET_KEY` and `RECAPTCHA_SITE_KEY`: used to render the reCAPTCHA element on index page.
      RECAPTCHA_SITE_KEY

Further there are some **required** [ENV Vars][env-vars] that you'll need to set in `production`.
These are covered in more detail in the [self-hosting docs](docs/self-hosting.md).
These can also be overridden in local `development` and `test` environments via your `.env` file.

  - `DEFAULT_MAP_CENTER_LAT`: the latitude of the default center of your map
  - `DEFAULT_MAP_CENTER_LON`: the longitude of the default center of your map
  - `RAILS_APP_ROOT_DOMAIN`: the HTTP host to use when generating URLS for emails, assets, etc... *(Default = `localhost:5000`)*
  - `SEND_GRID_API_KEY` and `SEND_GRID_USERNAME`: for sending emails.

#### ⚗️ Development data

### 🏁 Running the app

We use a [`Procfile`][procfile] to declare all of the processes we use.
This includes starting the Rails app (via the [Puma][puma] web server).
Use [Heroku-local][heroku-local] to start/stop all of the processes in the `Procfile`:

```bash
heroku local:start
```

*NOTE: You can shut everything down by hitting `^C` _(that's `Control` + `C`)_.*

Point your browser/client at <http://localhost:5000> to see the app in action!

With the app running, you should be able to sign in with the seeded admin account `admin@example.com` and the password `password1234`.

In order to see the Site Official View, you will need to create a new User and Host through the [Admin view](http://localhost:5000/admin).

1. Go to the “Testing Sites” tab to create a new Host.
1. Go to the “Location Officials” tab and create a new User.

    _NOTE:_ The User your create must be associated to the Host you just created.
    Also be sure the host address is correctly populated by Geocoder by checking the fields “latitude” and “longitude”.

## Example usage

This platform can be used the following way.

A local government IT team sets up the platform and designates where in the city a testing site will be located and how many officials will work at each location.

#### Citizen View

The city will market to the citizens the url of the site, the citizen can self diagnose symptoms and find a testing site if needed.

#### Testing Site Officials View

There are two main actions that can occur in the testing site officials view, increasing the number of test kits used, and keeping track of people in line waiting to receive a test kit.

If there are 3 individuals working a testing site, one can be administering the test, one can be capturing the patient information and updating the number of test kits used through the platform, and one can be keeping the line count up to date and organized.

#### Admin View

The admin view allows for new testing sites and testing site officials to be created/updated, as well as showing in real time the number of test kits used, total wait time and testing sites that may need additional resources, per testing site.

[deck]: https://docs.google.com/presentation/d/1dOQSBMMUycuwKto4_SnoCBAIxSTDLVvGNfzxb64Z7nI/edit#slide=id.p "Coronavirus Drive Through Testing Site Application"
[dotenv]: https://github.com/bkeepers/dotenv "A Ruby gem to load environment variables from `.env`."
[env-vars]: https://devcenter.heroku.com/articles/config-vars "Configuration and Config Vars"
[heroku-local]: https://devcenter.heroku.com/articles/heroku-local "Heroku Local"
[procfile]: https://devcenter.heroku.com/articles/procfile "Process Types and the Procfile"
[puma]: http://puma.io/ "A modern, concurrent web server for Ruby"
