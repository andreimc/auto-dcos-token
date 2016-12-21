FROM ruby:2

RUN curl -L https://dl.dropboxusercontent.com/u/10287287/Packages/phantomjs-2.1.1-linux-x86_64.tar.bz2 | tar -xjC /tmp/; \
    mv /tmp/phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/bin/phantomjs && rm -rf /tmp/phantomjs-2.1.1-linux-x86_64

WORKDIR /app
ADD Gemfile Gemfile.lock /app/
RUN bundle install
ADD . /app

ENTRYPOINT ["/app/users_create.rb"]