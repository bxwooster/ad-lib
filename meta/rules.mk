$(exe): code $(all_source) $(all_headers) \
  $(source_c) $(source_h) $(source_ext_h) | $(output_dir)
	@echo "Making the executable..."
	@meta/exe.sh

$(source_ext_h): | $(output_dir)
	@echo "Making '$(source_ext_h)'..."
	@meta/source_ext_h.sh

$(source_h): code $(all_source) | $(output_dir)
	@echo "Making '$(source_h)'..."
	@meta/source_h.sh

$(source_c): code | $(output_dir)
	@echo "Making '$(source_c)'..."
	@meta/source_c.sh

$(package_archive): $(exe) | $(package_dir)
	echo "Making '$(package_archive)'..."
	@meta/package_archive.sh

$(output_dir): | $(platform_dir)
	mkdir $(output_dir)

$(package_dir): | $(platform_dir)
	mkdir $(package_dir)

$(platform_dir): | $(base_dir)
	mkdir $(platform_dir)

$(base_dir):
	mkdir $(base_dir)
