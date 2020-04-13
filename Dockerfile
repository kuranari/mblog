FROM ruby:2.6.6
RUN apt-get update -qq && \
  apt-get install -y --no-install-recommends nodejs

WORKDIR /mblog
COPY Gemfile Gemfile.lock /mblog/
RUN bundle install

COPY . /mblog/
CMD ["rails", "s", "-b", "0.0.0.0"]
