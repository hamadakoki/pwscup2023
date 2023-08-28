NAME	= atk_pub
GET	= b_01.csv
# p.csv 
TARGET	= $(GET)

VER	:= $(shell date "+%Y-%m%d-%H%M%S")
ZIP	:= $(NAME)-nodir-$(VER).zip

get: $(GET)

zip: $(TARGET)
	zip $(ZIP) $^

b_01.csv: sys/out/b.csv
	cp $< $@

%.csv: sys/out/%.csv
	cp $< $@

%.rb: sys/%.rb
	cp $< $@

clean:
	rm -f *~ $(GET)
