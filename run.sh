
#!/bin/bash
  
unzip vendor.zip
if [[ ! -e .bundle ]]; then
            mkdir .bundle
fi
cp config .bundle

bundle install --local && cucumber features
