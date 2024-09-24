# FaceFusion

https://docs.facefusion.io
https://docs.facefusion.io/installation

https://github.com/facefusion/facefusion

## github

    git clone --recurse-submodules git@github.com:mazurkin/facefusion.git facefusion
    cd facefusion

## installation

    make env-init
    make env-install

## run

    make run

## remove the filters

in `facefusion/content_analyser.py` find `PROBABILITY_LIMIT = 0.80` and set to `PROBABILITY_LIMIT = 100`
