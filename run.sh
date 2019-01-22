
#!/bin/bash
  
unzip vendor.zip
bundle install --local && bundle exec cucumber features
