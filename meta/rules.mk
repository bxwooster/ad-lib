$(exe): $(all-source) $(all-headers) $(all-c) $(all-h) | $(output-dir)
	$(cc) \
	  -o $(exe) \
	  $(all-c) \
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

$(all-h): code $(all-headers) | $(output-dir)
	rm -f $(all-h).tmp
	for feature in . $(features); do \
	  for file in \
	   `shopt -s nullglob; \
	    echo code/$$feature/*.c`; \
	  do \
	    awk \
		  'BEGIN{RS="{"} {print $$0, ";"; exit}' \
	    $$file >> $(all-h).tmp ; \
	  done ; \
	done ;
	mv $(all-h).tmp $(all-h)

$(all-c): code $(all-headers) | $(output-dir)
	rm -f $(all-c).tmp
	for feature in . $(features); do \
	  for file in \
	   `shopt -s nullglob; \
	    echo code/$$feature/*.h`; \
	  do \
	    echo "#include <$$file>" >> $(all-c).tmp ; \
	  done ; \
	done
	echo "#include <$(all-h)>" >> $(all-c).tmp
	for feature in . $(features); do \
	  for file in \
	   `shopt -s nullglob; \
	    echo code/$$feature/*.c`; \
	  do \
	    echo "#include <$$file>" >> $(all-c).tmp ; \
	  done ; \
	done
	mv $(all-c).tmp $(all-c)

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
