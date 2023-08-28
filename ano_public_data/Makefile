NAME	= ano_pub
GET	= p.csv
# g.rb common.rb
TARGET	= $(GET)

VER	:= $(shell date "+%Y-%m%d-%H%M%S")
ZIP	:= $(NAME)-nodir-$(VER).zip

get: $(GET)

zip: $(TARGET)
	zip $(ZIP) $^

%.csv: sys/out/%.csv
	cp $< $@

%.rb: sys/%.rb
	cp $< $@

clean:
	rm -f *~ $(GET)
