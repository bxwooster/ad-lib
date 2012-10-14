$(exe): $(all_source) $(all_headers) \
  $(source_c) $(source_h) $(source_ext_h) | $(output_dir)
	meta/exe.sh

$(source_ext_h): | $(output_dir)
	meta/source_ext_h.sh

$(source_h): code $(all_headers) | $(output_dir)
	meta/source_h.sh

$(source_c): code $(all_headers) | $(output_dir)
	meta/source_c.sh

$(package_archive): $(exe) | $(package_dir)
	meta/package_archive.sh

$(output_dir): | $(platform_dir)
	mkdir $(output_dir)

$(package_dir): | $(platform_dir)
	mkdir $(package_dir)

$(platform_dir): | $(base_dir)
	mkdir $(platform_dir)

$(base_dir):
	mkdir $(base_dir)
