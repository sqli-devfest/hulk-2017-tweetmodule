FROM hypriot/rpi-ruby

LABEL Description="Devfest 2017 Tweet module image" Vendor="SQLI" Version="1.0"

RUN apt-get update && apt-get install -y build-essential

ADD application/Gemfile application/Gemfile

ADD application/Gemfile.lock application/Gemfile.lock

WORKDIR /application

RUN bundler install

ADD application /application

ENTRYPOINT ruby tweetmodule.rb
