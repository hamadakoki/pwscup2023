OUT	= out
ID	= 03

A	= $(OUT)/a.csv
B	= $(OUT)/b.csv
O	= $(OUT)/o.csv
P	= $(OUT)/p.csv
F	= $(OUT)/f.csv
R	= $(OUT)/r.csv
ATK_SCORE	= $(OUT)/atk_scores.txt
ANO_SCORE	= $(OUT)/ano_scores.txt
SEED	= $(OUT)/seed.txt
MY_ID	= $(OUT)/my_id.txt

all: $(ANO_SCORE) $(ATK_SCORE)

run-example: $P $R $A $F
	ruby score_utility.rb $P $R $A
	ruby score_attack.rb $R $F

$(ATK_SCORE): $(MY_ID) $F $(OUT)
	ruby dup_f.rb $(MY_ID) $F $(OUT)
	ruby sp_atk.rb $(OUT) $(MY_ID) $@
	cat $@

$(MY_ID): $(OUT)
	echo $(ID) > $@

$F: $P $B $(OUT)
	ruby _atk_sort.rb $P $B > $@
	ruby check_f.rb $@

$B: $A $(OUT)
	./a2b.sh $< $@

$A: $O $(OUT)
	ruby _ano_rand.rb < $< > $@
	ruby check_a.rb $@

$(ANO_SCORE): $P $R $(SEED) $A $(OUT)
	ruby sp_ano.rb $P $R $(SEED) $A $@
	cat $@

$O: $P $R $(OUT)
	./pr2o.sh $P $R $@

$R: $(SEED) $(OUT)
	ruby g.rb $< $@

## for preriminary round
#$P: p-pre.csv $(OUT)
#	cp $< $@

#p-pre.csv:
#	ruby _gen_p.rb 123456789 > $@

## for main round
$P: p-main.csv $(OUT)
	cp $< $@

p-main.csv:
	ruby _gen_p.rb 123123123 > $@

$(SEED): $(OUT)
	./gen_seed.sh $@

$(OUT):
	mkdir $(OUT)

clean:
	rm -f tmp.*
	rm -f *~
	rm -fr $(OUT)
