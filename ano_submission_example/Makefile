NAME	= ano_sub
GET	= a.csv r.csv seed.txt
TARGET	= $(GET)

VER	:= $(shell date "+%Y-%m%d-%H%M%S")
ZIP	:= $(NAME)-nodir-$(VER).zip

get: $(GET)

zip: $(TARGET)
	zip $(ZIP) $^

%.csv: sys/out/%.csv
	cp $< $@
%.txt: sys/out/%.txt
	cp $< $@

clean:
	rm -f *~ $(GET)
