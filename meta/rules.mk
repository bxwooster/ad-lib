$(exe): $(all-source) $(all-headers) \
  $(source-c) $(source-h) $(source-ext-h) | $(output-dir)
	$(cc) \
	  -o $(exe) \
	  $(source-c) \
	  -Wall \
	  -Wextra \
	  -std=gnu99 \
	  $(link-flags) \
	  -lm \
	  -lSDL2 \
	  -lSDL2_image \
	  -I. \
	  -I.config/$(platform)/include \
	  -g

$(source-ext-h): | $(output-dir)
	cp meta/$(program).ext.h $(source-ext-h).tmp
	for include in $(includes); do \
	  echo "$$include" >> $(source-ext-h).tmp ; \
	done ;
	mv $(source-ext-h).tmp $(source-ext-h)

$(source-h): code $(all-headers) | $(output-dir)
	rm -f $(source-h).tmp
	for feature in . $(features); do \
	  for file in \
	   `shopt -s nullglob; \
	    echo code/$$feature/*.c`; \
	  do \
	    awk \
		  'BEGIN{RS="{"} {print $$0, ";"; exit}' \
	    $$file >> $(source-h).tmp ; \
	  done ; \
	done ;
	mv $(source-h).tmp $(source-h)

$(source-c): code $(all-headers) | $(output-dir)
	rm -f $(source-c).tmp
	echo "#include <$(source-ext-h)>" >> $(source-c).tmp
	for feature in . $(features); do \
	  for file in \
	   `shopt -s nullglob; \
	    echo code/$$feature/*.h`; \
	  do \
	    echo "#include <$$file>" >> $(source-c).tmp ; \
	  done ; \
	done
	echo "#include <$(source-h)>" >> $(source-c).tmp
	for feature in . $(features); do \
	  for file in \
	   `shopt -s nullglob; \
	    echo code/$$feature/*.c`; \
	  do \
	    echo "#include <$$file>" >> $(source-c).tmp ; \
	  done ; \
	done
	mv $(source-c).tmp $(source-c)

$(package-archive): $(exe) | $(package-dir)
	false #disabled at the moment
	cp -r \
	  $(exe) \
	  data \
	  $(package-dir)
	# art ?
	# dlls ?
	tar -cj $(package-dir) -f $(package-archive)

$(output-dir): | $(platform-dir)
	mkdir $(output-dir)

$(package-dir): | $(platform-dir)
	mkdir $(package-dir)

$(platform-dir): | $(base-dir)
	mkdir $(platform-dir)

$(base-dir):
	mkdir $(base-dir)
