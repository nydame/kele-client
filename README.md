# kele-client
A Ruby gem that facilitates access to the [Bloc API](https://blocapi.docs.apiary.io/)
## Description
### This Ruby gem lets your Rails app use the Bloc API to fetch information about any enrolled student.
### Requires the following gems: 
 - [HTTParty](https://github.com/jnunemaker/httparty) for making HTTP requests
 - [OJ](https://github.com/ohler55/oj) JSON parser
 - [Sanitize](https://github.com/rgrove/sanitize) for blocking unsafe text input
 - [PP](https://rubygems.org/gems/pp/versions/0.1.1) for formatting output
## Installation
Simply run ```gem install kele-client```.
## Use
### Import keke-client into your code.
### Create a new client, e.g. ```kele = Kele.new("abcdef@abc.com")```
### Make calls with Bloc API methods, e.g. ```current_user = kele.get_me``` or ```mentor_time_slots = kele.get_mentor_availability(123)```

For a complete list of Bloc API methods please see [Bloc API documentation](https://www.bloc.io/api/v1)
