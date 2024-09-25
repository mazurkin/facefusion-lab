# facefusion

## description

- https://docs.facefusion.io
- https://docs.facefusion.io/installation

## github

- https://github.com/facefusion/facefusion

# facefusion-lab

## github

    git clone --recurse-submodules git@github.com:mazurkin/facefusion-lab.git facefusion-lab
    cd facefusion-lab

## installation

    make env-init
    make env-install

## run

    make run

## remove the filters

in `facefusion/facefusion/content_analyser.py` find `PROBABILITY_LIMIT = 0.80` and set to `PROBABILITY_LIMIT = 100`
