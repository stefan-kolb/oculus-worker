FROM ruby:2.3.1

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY Gemfile /usr/src/app/
RUN bundle install

COPY . /usr/src/app

ENV RACK_ENV=development

CMD bundle exec rake crawler:all