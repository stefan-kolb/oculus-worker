FROM ruby:alpine
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ONBUILD COPY Gemfile /usr/src/app/
ONBUILD RUN bundle install

ONBUILD COPY . /usr/src/app
CMD ["bundle exec rake crawler:all"]