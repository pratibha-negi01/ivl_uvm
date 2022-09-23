all:
	make --no-print-directory -f ovl_always
	make --no-print-directory -f OVL_trans
	make --no-print-directory -f OVL_unchange
	make --no-print-directory -f OVL_zero_one_hot
	
	

clean:
	  rm -fr a.out *.log *.vcd tee

help:
	make --no-print-directory -f ovl_always help
	make --no-print-directory -f OVL_trans help
	make --no-print-directory -f OVL_unchange  help
	make --no-print-directory -f OVL_zero_one_hot  help
	


