$(exe): $(all_source) $(all_headers) \
  $(source_c) $(source_h) $(source_ext_h) | $(output_dir)
	$(cc) \
	  -o $(exe) \
	  $(source_c) \
	  -Wall \
	  -Wextra \
	  -std=gnu99 \
	  $(link_flags) \
	  -lm \
	  -lSDL2 \
	  -lSDL2_image \
	  -I. \
	  -I.config/$(platform)/include \
	  -g

$(source_ext_h): | $(output_dir)
	cp meta/$(program).ext.h $(source_ext_h).tmp
	for include in $(includes); do \
	  echo "$$include" >> $(source_ext_h).tmp ; \
	done ;
	mv $(source_ext_h).tmp $(source_ext_h)

$(source_h): code $(all_headers) | $(output_dir)
	rm -f $(source_h).tmp
	for feature in . $(features); do \
	  for file in \
	   `shopt -s nullglob; \
	    echo code/$$feature/*.c`; \
	  do \
	    awk \
		  'BEGIN{RS="{"} {print $$0, ";"; exit}' \
	    $$file >> $(source_h).tmp ; \
	  done ; \
	done ;
	mv $(source_h).tmp $(source_h)

$(source_c): code $(all_headers) | $(output_dir)
	rm -f $(source_c).tmp
	echo "#include <$(source_ext_h)>" >> $(source_c).tmp
	for feature in . $(features); do \
	  for file in \
	   `shopt -s nullglob; \
	    echo code/$$feature/*.h`; \
	  do \
	    echo "#include <$$file>" >> $(source_c).tmp ; \
	  done ; \
	done
	echo "#include <$(source_h)>" >> $(source_c).tmp
	for feature in . $(features); do \
	  for file in \
	   `shopt -s nullglob; \
	    echo code/$$feature/*.c`; \
	  do \
	    echo "#include <$$file>" >> $(source_c).tmp ; \
	  done ; \
	done
	mv $(source_c).tmp $(source_c)

$(package_archive): $(exe) | $(package_dir)
	false #disabled at the moment
	cp -r \
	  $(exe) \
	  data \
	  $(package_dir)
	# art ?
	# dlls ?
	tar -cj $(package_dir) -f $(package_archive)

$(output_dir): | $(platform_dir)
	mkdir $(output_dir)

$(package_dir): | $(platform_dir)
	mkdir $(package_dir)

$(platform_dir): | $(base_dir)
	mkdir $(platform_dir)

$(base_dir):
	mkdir $(base_dir)
