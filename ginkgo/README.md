# Ginkgo

Go 1.5 + Ginkgo + Gomega

You can use it this way

````bash
	RETSU_PATH=/go/src/github.com/gopherscl/retsu
	docker run -ti \
		--name gopherscl_retsu_testing \
		-v $(shell pwd):${RETSU_PATH} hermanjunge/ginkgo \
		/bin/bash -c "cd ${RETSU_PATH} && make manual-test"

````