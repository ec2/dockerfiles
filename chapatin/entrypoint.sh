#!/bin/bash

export DISPLAY=:10
Xvfb :10 -ac &

ginkgo -v tests
