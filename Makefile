.PHONY: appbundle
appbundle:
	flutter build appbundle
	cd build/app/outputs/bundle/release && \
		cp -r ../../../intermediates/stripped_native_libs/release/out/lib . && \
		cd lib && \
		zip -r ../debug_symbols.zip .
