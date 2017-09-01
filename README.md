# Screenshot Demo

<img src="https://raw.githubusercontent.com/AndresCL/rails-interview-project/master/public/img/cs_ss.png">

# Instructions

`bundle install`

Install Webpacker to work with VueJS2
(**** ATTENTION: DO NOT OVERWRITE WHEN ASKED ****)

`rails webpacker:install && rails webpacker:install:vue`

`bundle exec rake db:setup`

`rails s`

Now the project should be running (It will take some time the first time due to compiling)

`Open browser at: http://localhost:3000`

# Try API via GET

Grab a valid api_key from tenants db and use it as tenantkey like this:

`http://localhost:3000/api/questions?tenantkey=c861d12c8b34c7376fbf9b2bd852e950&q=[{"key":"id","value":2, "operator":"="},{"key":"title","value":"a","operator":"LIKE"}]`

It should show public questions and it answers filtered by query parameter.
If request counter is greater than 100 per Tenant, throttle to 1 request per 10 seconds by throwing 503 Service Unavailable

# Migrations

* Run Migrations (If needed)

`bin/rails db:migrate VERSION=20170831190718`

# Query Parameter

The Query Parameter is defined by variable "qp" and it can be array of values like this:

`q=[{"key":"id","value":2,"operator":"="},{"key":"title","value":"eth","operator":"LIKE"}]`

# Tests

To Test Tenant API Key
`bin/rails test test/controllers/api_controller_test.rb:9`
`bin/rails test test/controllers/api_controller_test.rb:15`


# Rails Engineer Candidate Interview Project

Thanks for taking the time to complete this exercise. We're excited that you're considering joining our amazing team.

This Rails application is a basic skeleton of an app that serves an API about questions and answers. It already includes 4 basic models:

1.  Question
2.  Answer
3.  User
4.  Tenant

A Question can have one or more answers, and can be private. Every Answer belongs to one question. Each Question has an asker (User), and each Answer has a provider (User).

A Tenant is a consumer of the API you are going to write. A db/seeds.rb file is included to preload the database with test data when you setup the DB.

## You need to accomplish the following tasks:

*   Add a RESTful, read-only API to allow consumers to retrieve Questions with Answers as JSON (no need to retrieve Answers on their own). The response should include Answers inside their Question as well as include the id and name of the Question and Answer users.
*   Don't return private Questions in the API response.
*   Require every API request to include a valid Tenant API key, and return an HTTP code of your choice if the request does not include a valid key.
*   Track API request counts per Tenant.
*   Add an HTML dashboard page as the root URL that shows the total number of Users, Questions, and Answers in the system, as well as Tenant API request counts for all Tenants.  Style it enough to not assault a viewer's sensibilities.
*   Add tests around the code you write as you deem appropriate. Assume that the API cannot be changed once it's released and test accordingly.
*   You are welcome to add any models or other code you think you need, as well as any gems.

## Extra credit features you might consider:

*   Allow adding a query parameter to the API request to select only Questions that contain the query term(s).  Return an appropriate HTML status code if no results are found.
*   Add a piece of middleware to throttle API requests on a per-Tenant basis. After the first 100 requests per day, throttle to 1 request per 10 seconds.

## Project Setup

Fork then clone this repo locally, and from the top-level directory run:

`bundle install`

`bundle exec rake db:setup`

To make sure it's all working,

`rails s`

You should see this same information.

## Submitting your project

Send us a zip file or the Github URL of the whole project for us to evaluate it.  If you need to add any additional instructions to the README please put them at the very top of that file and mention.  Expect to discuss your design decisions during the interview.
