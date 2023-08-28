NAME	= atk_starting_kit
GET	= my_id.txt f_01_03.csv f_05_03.csv
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
