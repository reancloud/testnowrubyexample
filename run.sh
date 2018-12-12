
#!/bin/bash
  
unzip vendor.zip
if [[ ! -e .bundle ]]; then
            mkdir .bundle
fi

bundle install --local && cucumber features
