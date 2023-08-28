NAME	= ano_sp

GET	= sp_ano.rb common.rb
TARGET	= metadata $(GET)


VER	:= $(shell date "+%Y-%m%d-%H%M%S")
ZIP	:= $(NAME)-nodir-$(VER).zip

get: $(GET)

zip: $(TARGET)
	zip $(ZIP) $^

%.rb: sys/%.rb
	cp $< $@

clean:
	rm -f *~ $(GET)
