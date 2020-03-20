# Coronavirus Testing Management Platform

If you need help setting this platform up, please email me at brandon.cummings@berkeley.edu, we are more than happy to help set this up for any city.

-Brandon

## Introduction

This platform was created for local cities or municipalities to help manage corona virus testing sites. This platform accomplishes 3 main goals:

Questionnaire to self diagnose symptoms: If symptoms are present, the user will be shown a map that shows all local testing sites, and a google map link to direct them to the site.
Testing site management: For all testing sites, there is a portal to keep track of number of tests administered and number of patients in line.

Admin management: Full admin suite to create/edit testing site officials, testing sites, and a dashboard for analytics to gain real time insights.

## Proving the value of more testing centers:

Some local cities will not immediately see the need for more public testing centers and will need a digestible way of analyzing this solution, so we created a slide deck to explain why cities should implement this platform.

https://docs.google.com/presentation/d/1dOQSBMMUycuwKto4_SnoCBAIxSTDLVvGNfzxb64Z7nI/edit#slide=id.g718b396cd4_0_330


## Table Of Contents

1. Domain registration
2. Hosting setup
3. Google Maps API setup
4. Sendgrid setup
5. App setup
6. Recaptcha Setup
7. Example usage
8. Environment Variables

## Domain registration

I highly recommend not using GoDaddy to register your domain, you need to use a domain manager that allows you to update A records without having a static IP address, such as https://dnsimple.com/.

Go purchase a domain, such as the domain we purchased: atlanta-covid19-testing-sites.com

Once you have registered this domain, we will revisit to connect heroku site and to prove to google you are the owner by adding CNAME records.

## Hosting setup

I highly recommend using Heroku, it’s very easy to get setup.

Heroku signup: https://signup.heroku.com/t/platform

Setup the heroku app and prepare an app to push to from your command line. Head to your settings of this app you just created, select “Reveal Config Vars” these are all environment variables for you application.
Save RAILS_APP_ROOT_DOMAIN as the root domain you just purchased.

## Google Maps API setup

The google maps api is a crucial part of this application, so please follow these steps:

Go to https://console.developers.google.com/
1. Create a new project called “COVID19-Testing”
2. Enable the Google Maps Javascript API
3. You will need to have a verified domain in order to create credentials, create a verified domain by following the steps.
4. Visit https://console.developers.google.com/apis/credentials/domainverification Follow the steps provided, I had to add a CNAME record to my DNS that pointed to the value google provided
5. Create API credentials, which will produce an API key that you should keep safe and never 	  store publicly, only store within environment variables.
6. Restrict your API key to only the Google Maps Javascript API and add the urls that you purchased, so only those urls can access your application. In our case we added the following urls:

    https://www.atlanta-covid19-testing-sites.com
    https://atlanta-covid19-testing-sites.com
    http://localhost:3000 (for developing locally)

Once you have your API key, save it to your heroku apps settings, under the “Reveal Config Vars”, and add it as GOOGLE_API_KEY.

## Sendgrid Setup

Go to https://sendgrid.com/ and signup. Go to https://app.sendgrid.com/settings/api_keys to setup an API key with full access.

Save this API key in your heroku config vars as SEND_GRID_API_KEY
Also save to your heroku config vars SEND_GRID_USERNAME with the value of “apikey” (literally the word “apikey” not your actual API key)

## App setup

Fork this repo so that you can push any changes to your own custom repository.

Once pulled down, run:

rake db:create

Here is a great resource to get rails up and running: https://www.tutorialspoint.com/ruby-on-rails/rails-installation.htm

Once you have the repo, follow these steps:

1. bundle install
2. rake db:create db:migrate
3. Store your environment variables, from your command line write:
4. export GOOGLE_API_KEY=<api_key_you_created>
5. export RECAPTCHA_SITE_KEY=<recaptcha site key>
6. export RECAPTCHA_SECRET_KEY=<recaptcha secret key>

Run the app locally by running “rails s”, then visit http://localhost:3000 on your local machine and browser of choice.

In order to see the Site Official View, you will need to create a new User and Host through the Admin view, and in order to view the admin view at http://localhost:3000/admin you will need to create a new AdminUser.

1. Run “rails c” to run the rails console
2. Then create a new AdminUser by running “AdminUser.create(email: “example@gmail.com”, password: “password”)
3. Then visit http://localhost:3000/admin, sign in with the email and password created.
4. You can then go to the tab “Testing Sites” and “Location Officials” to create a new Host and User.
5. The User your create must be associated to a Host, and make sure the host address is correctly populated by Geocoder by  checking the fields “latitude” and “longitude”, if the address is correct, those fields should be populated correctly.

You will most likely run into some issues with setup, most can be googled and have been addressed, stay patient and you will get through it.

## Recaptcha Setup

Recaptcha is used to prevent bots from overwhelming your site and wasting you google maps API calls by implementing a simple checkbox that says "I am not a robot".

To setup, visit https://www.google.com/recaptcha/admin/create

Choose V2 "Checkbox"

Input the domains you have purchased.

Save RECATPCHA_SITE_KEY and RECATPCHA_SECRET_KEY as environment variables on your heroku instance.

## Example usage

This platform can be used the following way.

A local government IT team sets up the platform and designates where in the city a testing site will be located and how many officials will work at each location.

Citizen View: The city will market to the citizens the url of the site, the citizen can self diagnose symptoms and find a testing site if needed.

Testing Site Officials View: there are two main actions that can occur in the testing site officials view, increasing the number of test kits used, and keeping track of people in line waiting to receive a test kit.

If there are 3 individuals working a testing site, one can be administering the test, one can be capturing the patient information and updating the number of test kits used through the platform, and one can be keeping the line count up to date and organized.

Admin View: The admin view allows for new testing sites and testing site officials to be created/updated, as well as showing in real time the number of test kits used, total wait time and testing sites that may need additional resources, per testing site.

## Environment Variables

The environment variables needed to be set in heroku are as follows:

1. GOOGLE_API_KEY - your Google Maps Javascript api key
2. DEFAULT_MAP_CENTER_LAT - the latitude of the default center of your map
3. DEFAULT_MAP_CENTER_LON - the longitude of the default center of your map
4. RAILS_APP_ROOT_DOMAIN - root domain you are using
5. SEND_GRID_USERNAME - which is "apikey" (the literal word "apikey")
6. SEND_GRID_API_KEY - your sendgrid api key
7. RECATPCHA_SECRET_KEY - Recaptcha secret key
8. RECATPCHA_SITE_KEY - Recaptcha site key
