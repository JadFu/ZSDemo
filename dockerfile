# Use the official Ruby image with the CORRECT!!! version
FROM ruby:3.1.2

# Set the working directory inside the container
WORKDIR /app

# Install dependencies
RUN apt-get update && apt-get install -y \
  build-essential \
  nodejs

# Copy Gemfile and Gemfile.lock to the container
COPY Gemfile Gemfile.lock ./

# Install gems
RUN gem install bundler:2.2.25
RUN bundle install

# Copy the rest of the application files to the container
COPY . .

# Expose port 3000, which is the default port for Rails applications
EXPOSE 3000

# Start the Rails application server
CMD ["rails", "server", "-b", "0.0.0.0"]