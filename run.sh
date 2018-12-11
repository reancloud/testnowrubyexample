
#!/bin/bash
  
unzip vendor.zip
if [[ ! -e .bundle ]]; then
            mkdir .bundle
fi
cp config .bundle

bin/cucumber features
