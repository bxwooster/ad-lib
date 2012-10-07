$(main-exe): code/*.c code/*.h $(all-c) $(all-h) | $(output-dir)
	gcc \
	-Wall \
	-Wextra \
	-std=gnu99 \
	$(all-c) \
	-DPLATFORM_$(uppercase-platform) \
	$(link-flags) \
	-lSDL2 \
	-lSDL2_image \
	-I. \
	-I.config/include \
	-lm \
	-g \
	-o $(main-exe)

$(all-h): code code/*.c | $(output-dir)
	rm -f $(all-h).tmp
	rm -f $(all-h)
	for feature in . $(features); do \
	  for file in `echo code/$$feature/*.c`; do \
	    awk 'BEGIN{RS="{"} {print $$0, ";"; exit}' $$file >> $(all-h).tmp ; \
	  done ; \
    done ;
	mv $(all-h).tmp $(all-h)

$(all-c): code | $(output-dir)
	rm -f $(all-c).tmp
	rm -f $(all-c)
	for feature in . $(features); do \
	  for file in `shopt -s nullglob; echo code/$$feature/*.h`; do \
	    echo "#include <$$file>" >> $(all-c).tmp ; \
	  done ; \
	done
	echo "#include <$(all-h)>" >> $(all-c).tmp
	for feature in . $(features); do \
	  for file in `echo code/$$feature/*.c`; do \
	    echo "#include <$$file>" >> $(all-c).tmp ; \
	  done ; \
	done
	mv $(all-c).tmp $(all-c)

$(package-archive): $(main-exe) | $(package-dir)
	false #disabled at the moment
	cp -r \
		$(main-exe) \
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
