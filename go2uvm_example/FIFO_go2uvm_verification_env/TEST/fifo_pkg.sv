package fifo_pkg;

parameter DATA_WIDTH=8;
parameter ADDR_WIDTH=4;
typedef enum bit[1:0] {POP,PUSH,RST}fifo_op;

endpackage : fifo_pkg
