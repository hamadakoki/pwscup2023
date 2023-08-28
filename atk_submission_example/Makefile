NAME	= atk_sub
GET	= my_id.txt
TARGET	= $(GET)

VER	:= $(shell date "+%Y-%m%d-%H%M%S")
ZIP	:= $(NAME)-nodir-$(VER).zip

get: $(GET)

zip: $(TARGET)
	zip $(ZIP) $^ f_??_??.csv

my_id.txt: sys/out/my_id.txt
	cp sys/out/f_??_??.csv .
	cp $< $@

clean:
	rm -f *~ $(GET) f_??_??.csv
