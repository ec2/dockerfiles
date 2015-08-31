# Chapatín

### Building your docker image

Refer to the ``Dockerfile`` inside the ``docker`` folder. Essentialy, the image contains golang, the testing libraries, Java 1.8, Selenium, the browsers and the drivers.

Yes, is a heavy one. But that way, you don't need to worry about configuring the environment yourself.

If you want to build your own image, say, ``shalldoek/chapatin``, just go inside the ``docker`` folder and do

	docker build -t shalldoek/chapatin .

### Manually run the container

Verify the contents of the file ``entrypoint.sh`` to be

````bash
#!/bin/bash

export DISPLAY=:10
sudo Xvfb :10 -ac &

ginkgo -v tests
````

And run

	docker rm chapatin_test_myapp &>/dev/null; docker run --rm --name chapatin_test_myapp -v $(pwd):/testapp hermanjunge/chapatin

The above command will do the following:

* Remove any container named ``chapatin_test_myapp``.
* Create a container named ``chapatin_test_myapp`` and remove it once finished the operation.
* Mount this directory ``minsm`` as a volume into the container's ``/testapp`` volume.

The container is set up to execute the ``entrypoint.sh`` file. In this particular case, we want an instance of X server running (for the browser to operate) and that ``ginkgo`` process the files in the ``test`` directory.

If you don't have any test written, your output will be most likely akin to

````bash
[ hermanjunge: myapp ]$ docker rm chapatin_test_myapp &>/dev/null; docker run --rm --name chapatin_test_myapp -v $(pwd):/testapp hermanjunge/chapatin
Running Suite: Chapatín MyAPP Suite
====================================
Random Seed: 1441063759
Will run 0 of 0 specs


Ran 0 of 0 Specs in 0.928 seconds
SUCCESS! -- 0 Passed | 0 Failed | 0 Pending | 0 Skipped PASS

Ginkgo ran 1 suite in 3.325289845s
Test Suite Passed
````
