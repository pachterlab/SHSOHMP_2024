include Mf.common

.SECONDARY:

.PHONY: all

all: sims_run

sims_run:
	$(MAKE) All_Gene_Sims       genome=human_CR_3.0.0   sample=10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo    threadRun=20/run1
	$(MAKE) All_Gene_Sims       genome=human_CR_3.0.0   sample=10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneYes   threadRun=20/run1
	$(MAKE) All_Gene_Sims       genome=human_CR_3.0.0   sample=10X/3/pbmc_5k_sims_human_CR_3.0.0_MultiGeneNo_OnlyExonicReads   threadRun=20/run1

############################################################ Versions
simpleaf    := simpleaf-salmon_0.15.1_1.10.0
alevin-fry  := salmon-alevin-fry_1.10.0_0.8.2
kbpy        := kallisto_0.50.1
STAR        := STAR_2.7.9a

############################################################ tools and options
# Gene: standard gene expression
	
All_Gene_Sims: Gene/kbpy \
               Gene/STAR_sims \
               Gene/simpleaf

Gene/STAR_sims:
	make -f Mf.count count/$(STAR)/$(genome)/fullSA/10X_noSAM_sims_mult_ENCODE/$(sample)/$(threadRun)/CO
	make -f Mf.count count/$(STAR)/$(genome)/sparseSA3/10X_noSAM_sims_mult_ENCODE/$(sample)/$(threadRun)/CO

Gene/kbpy:
	make -f Mf.count count/$(kbpy)/$(genome)/standard_1/default/$(sample)/$(threadRun)/CO
	make -f Mf.count count/$(kbpy)/$(genome)/standard_1/mult/$(sample)/$(threadRun)/CO
	make -f Mf.count count/$(kbpy)/$(genome)/nac_1/default/$(sample)/$(threadRun)/CO
	make -f Mf.count count/$(kbpy)/$(genome)/nac_1/mult/$(sample)/$(threadRun)/CO
	make -f Mf.count count/$(kbpy)/$(genome)/standard_offlist_1/default/$(sample)/$(threadRun)/CO
	make -f Mf.count count/$(kbpy)/$(genome)/standard_offlist_1/mult/$(sample)/$(threadRun)/CO
	make -f Mf.count count/$(kbpy)/$(genome)/nac_offlist_1/default/$(sample)/$(threadRun)/CO
	make -f Mf.count count/$(kbpy)/$(genome)/nac_offlist_1/mult/$(sample)/$(threadRun)/CO
	make -f Mf.count count/$(kbpy)/$(genome)/standard_offlistoverhang2_1/default/$(sample)/$(threadRun)/CO
	make -f Mf.count count/$(kbpy)/$(genome)/standard_offlistoverhang2_1/mult/$(sample)/$(threadRun)/CO
	make -f Mf.count count/$(kbpy)/$(genome)/nac_offlistoverhang2_1/default/$(sample)/$(threadRun)/CO
	make -f Mf.count count/$(kbpy)/$(genome)/nac_offlistoverhang2_1/mult/$(sample)/$(threadRun)/CO
	make -f Mf.count count/$(kbpy)/$(genome)/standard_offlistoverhang3_1/default/$(sample)/$(threadRun)/CO
	make -f Mf.count count/$(kbpy)/$(genome)/standard_offlistoverhang3_1/mult/$(sample)/$(threadRun)/CO
	make -f Mf.count count/$(kbpy)/$(genome)/nac_offlistoverhang3_1/default/$(sample)/$(threadRun)/CO
	make -f Mf.count count/$(kbpy)/$(genome)/nac_offlistoverhang3_1/mult/$(sample)/$(threadRun)/CO
	make -f Mf.count count/$(kbpy)/$(genome)/standard_offlistoverhang4_1/default/$(sample)/$(threadRun)/CO
	make -f Mf.count count/$(kbpy)/$(genome)/standard_offlistoverhang4_1/mult/$(sample)/$(threadRun)/CO
	make -f Mf.count count/$(kbpy)/$(genome)/nac_offlistoverhang4_1/default/$(sample)/$(threadRun)/CO
	make -f Mf.count count/$(kbpy)/$(genome)/nac_offlistoverhang4_1/mult/$(sample)/$(threadRun)/CO
	make -f Mf.count count/$(kbpy)/$(genome)/standard_offlistoverhang5_1/default/$(sample)/$(threadRun)/CO
	make -f Mf.count count/$(kbpy)/$(genome)/standard_offlistoverhang5_1/mult/$(sample)/$(threadRun)/CO
	make -f Mf.count count/$(kbpy)/$(genome)/nac_offlistoverhang5_1/default/$(sample)/$(threadRun)/CO
	make -f Mf.count count/$(kbpy)/$(genome)/nac_offlistoverhang5_1/mult/$(sample)/$(threadRun)/CO
	make -f Mf.count count/$(kbpy)/$(genome)/standard_offlistoverhang6_1/default/$(sample)/$(threadRun)/CO
	make -f Mf.count count/$(kbpy)/$(genome)/standard_offlistoverhang6_1/mult/$(sample)/$(threadRun)/CO
	make -f Mf.count count/$(kbpy)/$(genome)/nac_offlistoverhang6_1/default/$(sample)/$(threadRun)/CO
	make -f Mf.count count/$(kbpy)/$(genome)/nac_offlistoverhang6_1/mult/$(sample)/$(threadRun)/CO

Gene/simpleaf:
	make -f Mf.count count/$(simpleaf)/$(genome)/splici/rad_crlike/$(sample)/$(threadRun)/CO
	make -f Mf.count count/$(simpleaf)/$(genome)/splici/sketch_crlike/$(sample)/$(threadRun)/CO
	make -f Mf.count count/$(simpleaf)/$(genome)/splici/rad_crlikeem/$(sample)/$(threadRun)/CO
	make -f Mf.count count/$(simpleaf)/$(genome)/splici/sketch_crlikeem/$(sample)/$(threadRun)/CO
	make -f Mf.count count/$(simpleaf)/$(genome)/standard/rad_crlike/$(sample)/$(threadRun)/CO
	make -f Mf.count count/$(simpleaf)/$(genome)/standard/sketch_crlike/$(sample)/$(threadRun)/CO
	make -f Mf.count count/$(simpleaf)/$(genome)/standard/rad_crlikeem/$(sample)/$(threadRun)/CO
	make -f Mf.count count/$(simpleaf)/$(genome)/standard/sketch_crlikeem/$(sample)/$(threadRun)/CO


