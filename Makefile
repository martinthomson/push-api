support_dir ?= $(CURDIR)/.support
tidy ?= $(shell which tidy 2>/dev/null)
tidy ?= $(support_dir)/bin/tidy

$(tidy5): 
	if [ ! -d $(support_dir)/tidy-html5 ]; then \
	  mkdir -p $(support_dir); \
	  git clone https://github.com/htacg/tidy-html5.git $(support_dir)/tidy-html5; \
	fi
	cd $(support_dir)/tidy-html5/build/cmake && \
	  cmake ../.. -DCMAKE_INSTALL_PREFIX=$(support_dir) -DCMAKE_BUILD_TYPE=Release && \
	  make && make install

.PHONY: check
check: $(tidy)
	$(tidy) -quiet -config tidyconf.txt -errors index.html

.PHONY: tidy
tidy: $(tidy)
	-$(tidy) -quiet -config tidyconf.txt -modify index.html
