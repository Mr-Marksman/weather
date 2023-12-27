FROM ruby:2.7.4
WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN bundle install
COPY . .
EXPOSE 3000
CMD ["sh", "-c", "rails db:migrate && rails runner 'HistoricalWeatherExtractionService.call' && rails server -b 0.0.0.0"]
