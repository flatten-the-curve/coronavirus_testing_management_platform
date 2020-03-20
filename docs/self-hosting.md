# Deploying your own instance

This documentation explains how to set up your own instance of this tool.
We prefer Heroku as the hosting platform, and the instructions are written from that angle.
You can adjust to your own hosting preference as needed.

## Table Of Contents

1. [Domain Registration](#domain-registration)
1. [Hosting Setup](#hosting-setup)
1. [Google Maps API Setup](#google-maps-api-setup)
1. [Sendgrid Setup](#sendgrid-setup)
1. [Recaptcha Setup](#recaptcha-setup)
1. [Environment Variables](#environment-variables)

For local development instructions, please see the [`README`](../README.md).

## Domain Registration

We recommend a domain registrar and DNS provider that supports the `ALIAS`/`ANAME` record type.
This is required to [configure your DNS for a root domain][dns-config], if you are using a hosting provider such as [Heroku][heroku].

You probably want a domain that is specific to your municipality and/or geographical region. e.g., `atlanta-covid19-testing-sites.com`

## Hosting Setup

We recommend using [Heroku][heroku], it's easy to get setup.

Setup the Heroku app and prepare an app to push to from your command line.
Head to your settings of this app you just created, select “Reveal Config Vars” these are all environment variables for you application.
Save `RAILS_APP_ROOT_DOMAIN` as the root domain you just purchased.

## Google Maps API Setup

The [Google Maps API][google-maps-api] is a crucial part of this application, so please follow these steps:

1. Create a new project called “COVID19-Testing”
1. Enable the Google Maps Javascript API
1. You will need to have a verified domain in order to create credentials, create a verified domain by following the steps.

    1. From the Google console, go to the [domain verification][google-domain-verification] page.
    1. Follow the instructions, being sure to add a `CNAME` record to your DNS that points to the value Google gives you.

1. Create Google Maps API credentials.

    1. From the Google console, go to the "Credentials" tab.
    1. Create a new key and store it somewhere safe.
    **NEVER** store this key publicly, such as in your source code.
    1. Restrict your API key to only the Google Maps Javascript API and add the domains that you purchased, so only those domains can access your application.
    In our case we added the following urls:

    ```
    https://www.atlanta-covid19-testing-sites.com
    https://atlanta-covid19-testing-sites.com
    http://localhost:5000
    ```

    _NOTE:_ the `localhost:5000` is for local development testing.

1. Open your Heroku app's Settings, then “Reveal Config Vars”, and add the Google Maps API key as `GOOGLE_API_KEY`.

## Sendgrid Setup

Go to [Sendgrid][sendgrid] and sign up.
Then visit the [API Keys Settings][sendgrid-keys] to setup an API key with **full access**.

Next, open your Heroku app's Settings, then “Reveal Config Vars”, and add the Sendgrid API Key with the name `SEND_GRID_API_KEY`.
Also add a Heroku Config Var with the name `SEND_GRID_USERNAME` and a vlue of `apikey`.

## Recaptcha Setup

Recaptcha is used to prevent bots from overwhelming your site and wasting you Google Maps API calls by implementing a simple checkbox that says "I am not a robot".

To set it up:

1. Visit [reCAPTCHA setup].
1. Choose V2 "Checkbox"
1. Input the domains you have purchased.
1. In your Heroku app's Settings, add the `RECAPTCHA_SITE_KEY` and `RECAPTCHA_SECRET_KEY` Config Vars with the values from the reCAPTCHA setup.

## Environment Variables

The necessary and optional Environment Variables are described in the [`README`](../README.md#env-vars)

## Up and Running

With all of that done, you should be able to deploy your instance, and be up and running.
Good luck!

[dns-config]: https://devcenter.heroku.com/articles/custom-domains#configuring-dns-for-root-domains "Configuring DNS for root domains"
[google-domain-verification]: https://console.developers.google.com/apis/credentials/domainverification
[google-maps-api]: https://console.developers.google.com/ "Google Cloud Platform"
[heroku]: https://heroku.com "Cloud Application Platform"
[recaptcha]: https://www.google.com/recaptcha/admin/create
[sendgrid-keys]: https://app.sendgrid.com/settings/api_keys
[sendgrid]: https://sendgrid.com/
