NAME	= cup23-codalab-bundle
TARGET	= $(YAML) $(IMGS) $(HTMLS) $(B_ZIPS)

YAML	= competition.yaml
IMGS	= image-cup23.jpg
HTMLS	= data.html  evaluation.html  overview.html  terms_and_conditions.html teams.html additional1.html additional2.html additional3.html additional4.html additional5.html
ZIPS	= $(ANO_ZIPS) $(ATK_ZIPS)

VER	:= $(shell date "+%Y-%m%d-%H%M%S")
PWD	:= $(shell pwd)
ZIP	:= $(NAME)-nodir-$(VER).zip

## anonymization phase
ANO_REF	= ano_reference_data
ANO_PRO	= ano_scoring_program
ANO_SUB	= ano_submission_example
ANO_PUB = ano_public_data
ANO_SK	= ano_starting_kit
ANO_B	= $(ANO_REF).zip $(ANO_PRO).zip $(ANO_PUB).zip $(ANO_SK).zip
ANO_ZIPS	= $(ANO_B) $(ANO_PUB).zip

## attack phase
ATK_REF	= atk_reference_data
ATK_PRO	= atk_scoring_program
ATK_SUB	= atk_submission_example
ATK_PUB = atk_public_data
ATK_SK	= atk_starting_kit
ATK_B	=  $(ATK_REF).zip $(ATK_PRO).zip $(ATK_PUB).zip $(ATK_SK).zip
ATK_ZIPS	= $(ATK_B) $(ATK_SUB).zip

# zips for bundle
B_ZIPS	= $(ANO_B) $(ATK_B)

hoge:
	echo "commands: zip, sub, ano.run, atk.run"

sub: $(ANO_SUB).zip $(ATK_SUB).zip

zip: $(TARGET)
	zip $(ZIP) $^

# $ make atk.setup
# $ make atk.run

# $ make ano.setup
# $ make ano.run

atk.setup: atk.test_dir

ano.setup: ano.test_dir

%.test_dir: %.pro_zip %.ref_zip
	ruby setup.rb $@ $^

%.run: %.test_dir %.sub_zip
	rm -fr $*.test_dir/input/res $*.test_dir/output
	ruby run.rb $^
	cat $*.test_dir/output/scores.txt 

ano.ref_zip: $(ANO_REF).zip
	cp $< $@
ano.pro_zip: $(ANO_PRO).zip
	cp $< $@
ano.sub_zip: $(ANO_SUB).zip
	cp $< $@

atk.ref_zip: $(ATK_REF).zip
	cp $< $@
atk.pro_zip: $(ATK_PRO).zip
	cp $< $@
atk.sub_zip: $(ATK_SUB).zip
	cp $< $@

%.zip: %
	make -C $< zip ZIP=$(PWD)/$@

clean:
	make -C $(ANO_REF) clean
	make -C $(ANO_PRO) clean
	make -C $(ANO_SUB) clean
	make -C $(ANO_PUB) clean
	make -C $(ANO_SK) clean
	make -C $(ATK_REF) clean
	make -C $(ATK_PRO) clean
	make -C $(ATK_SUB) clean
	make -C $(ATK_PUB) clean
	make -C $(ATK_SK) clean
	rm -fr *.test_dir
	rm -f *~ *.pro_zip *.ref_zip *.sub_zip $(ZIPS)
