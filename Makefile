W ?= 2048
H ?= 1536
.PHONY: clean
clean:
	rm -f out.bmp out.ppm
out.bmp: out.ppm
	ppmtobmp out.ppm > out.bmp && >&2 echo "Done ppmtobmp" || >&2 echo "Failed ppmtobmp"
out.ppm:
	( echo "P6"; echo "$W $H"; echo "255" ) > out.ppm && >&2 echo "Done writing header" || >&2 "Failed writing header"; \
	for i in `seq $H`; do \
		dd status=none if=/dev/urandom bs=3 count=$W >> out.ppm || >&2 echo "dd failed at line $$i out of $H"; \
		>/dev/null expr $$i % 100 || >&2 echo "done $$i lines out of $H"; \
	done; \
	echo "Finished writing the ppm"
.DEFAULT_GOAL := out.bmp
