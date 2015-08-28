support_dir ?= $(CURDIR)/.support
tidy5 ?= $(shell which tidy5 2>/dev/null)
tidy5 ?= $(support_dir)/bin/tidy

$(tidy5): 
	if [ ! -d $(support_dir)/tidy-html5 ]; then \
	  mkdir -p $(support_dir); \
	  git clone https://github.com/htacg/tidy-html5.git $(support_dir)/tidy-html5; \
	fi
	cd $(support_dir)/tidy-html5/build/cmake && \
	  cmake ../.. -DCMAKE_INSTALL_PREFIX=$(support_dir) && \
	  make && make install

.PHONY: check
check: $(tidy5)
	$(tidy5) -quiet -config tidyconf.txt -errors index.html

.PHONY: tidy
tidy: $(tidy5)
	-$(tidy5) -quiet -config tidyconf.txt -modify index.html
