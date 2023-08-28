NAME	= ano_starting_kit
GET	= seed.txt r.csv a.csv
TARGET	= $(GET)

VER	:= $(shell date "+%Y-%m%d-%H%M%S")
ZIP	:= $(NAME)-nodir-$(VER).zip

get: $(GET)

zip: $(TARGET)
	zip $(ZIP) $^

%.txt: sys/out/%.txt
	cp $< $@

%.csv: sys/out/%.csv
	cp $< $@

clean:
	rm -f *~ $(GET)
