NAME	= ano_ref
GET	= p.csv
TARGET	= $(GET)

VER	:= $(shell date "+%Y-%m%d-%H%M%S")
ZIP	:= $(NAME)-nodir-$(VER).zip

get: $(GET)

zip: $(TARGET)
	zip $(ZIP) $^

%.csv: sys/out/%.csv
	cp $< $@

clean:
	rm -f *~ $(GET)
