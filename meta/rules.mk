$(main-exe): code/*.c code/*.h $(all-c) $(all-h) | $(build-dir)
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
	-lm \
	-g \
	-o $(main-exe)

$(all-h): code code/*.c | $(build-dir)
	rm -f $(all-h).tmp
	rm -f $(all-h)
	for file in `echo code/*.c`; do \
	  awk 'BEGIN{RS="{"} {print $$0, ";"; exit}' $$file >> $(all-h).tmp ; \
	done
	mv $(all-h).tmp $(all-h)

$(all-c): code | $(build-dir)
	rm -f $(all-c).tmp
	rm -f $(all-c)
	for file in `echo code/*.h`; do \
	  echo "#include <$$file>" >> $(all-c).tmp ; \
	done
	echo "#include <$(all-h)>" >> $(all-c).tmp
	for file in `echo code/*.c`; do \
	  echo "#include <$$file>" >> $(all-c).tmp ; \
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

$(build-dir): | $(platform-dir)
	mkdir $(build-dir)

$(package-dir): | $(platform-dir)
	mkdir $(package-dir)

$(platform-dir):
	mkdir -p $(platform-dir)

