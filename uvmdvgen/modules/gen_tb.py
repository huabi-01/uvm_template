import re
import os

Usage = """
This script generates testbench and signal interface
"""


def rtl_parser(rtl_file):
    input_pin_list = []
    output_pin_list = [ ]
    pin_dict = {}
    with open(rtl_file,"r") as fd:
        for line in fd: 
            re_module = re.match("^\s*module\s+(\w*)\s*\(",line)
            re_input = re.match("^\s*input\s*([\w*])?\s*(\w*)",line)
            re_output = re . match("^\s*output\s*([\w*])?\s*(\w*)",line)
            if(re_module):
                module = re_module.group(1)
            if re_input or re_output:
                line = re.sub(";"," ",line)
                line_list = line.strip().split()
                if "VDD" not in line or "VSS" not in line:
                    if "input" in line:
                        input_pin_list.append(line_list)
                    else:
                        output_pin_list.append(line_list)
                if(re.match("\s*task",line)):
                    break
        pin_dict["input"] = input_pin_list
        pin_dict["output"] = output_pin_list
    
    return pin_dict,module

def gen_tb_with_intf(conf):
    
    conf_dict = read_yaml(conf)
    
    rtl_file = conf_dict["tb_conf"]["rtl_file"]
    tb_name = conf_dict["tb_conf"]["tb_name"]
    intf_name = conf_dict["tb_conf"]["intf_name"]

    pin_dict,module = rtl_parser(rtl_file)

    input_pin_list = [ ]
    output_pin_list = [ ]

    for key ,all_pin_list in pin_dict.items():
        for pin_list in all_pin_list:
            if len(pin_list) == 2:
                if key == "input":
                    input_pin_list.append(pin_list[1])
                else:
                    output_pin_list.append(pin_list[1])
            else: 
                if key == "input":
                    input_pin_list.append(pin_list[2])
                else:
                    output_pin_list.append(pin_list[2])
    input_pin_str =",".join(input_pin_list)
    output_pin_str =",".join(output_pin_list)

    with open(tb_name,"w") as fd:
        fd.write(" interface {}(input bit clk,input bit rstn);\n".format(intf_name))
        for key,all_pin_list in pin_dict.items( ):
            fd.write("\t// {} pin\n".format(key) )
            for pin_list in all_pin_list:
                if len(pin_list) == 2:
                    fd.write("\tlogic" + "\t"*4 + pin_list[1] + ";\n")
                else:
                    fd.write("\tlogic {} {}; \n" .format(pin_list[1],pin_list[2]))
                    fd.write("\n" )

        fd.write("\tclocking drv_ cb@(posedge clk);\n")
        fd.write("\t\tdefault input #1 output #1\n" )
        fd.write("\t\tinput {};\n" . format(output_pin_str) ) 
        fd.write("\t\toutput {};\n" .format(input_pin_str))
        fd.write("\tendclocking\n")
        fd.write("\n")
        fd.write("endinterface\n")
        
        fd.write("\n")
        fd.write("module tb;\n")
        fd.write("bit clk;\n")
        fd.write("bit rstn;\n")
        fd.write("initial begin\n")
        fd.write("\tclk <= ~clk\n")
        fd.write("\tforever #5 clk <= ~clk\n")
        fd.write("end\n")

        fd.write("\n")
        fd.write("initial begin\n")
        fd.write("\trstn <= 0\n")
        fd.write("\t#12 rstn <= 1\n" )
        fd.write("end\n" )
        fd.write("\n")
        fd.write("{} u1 (\n".format(module))
        fd.write("// input pin\n")
        for pin in input_pin_list:
            fd.write("\t.{}(vif.{}),\n".format(pin,pin))
        fd.write("// output pin\n")
        
        last_pin_index = len(output_pin_list) - 1
        for index,pin in enumerate(output_pin_list):
            if index  != last_pin_index:
                fd.write("\t.{}(vif.{}),\n".format(pin,pin))
            else:
                fd.write("\t.{}(vif.{})\n".format(pin,pin))
        fd.write(");\n")
        fd.write("endmodule\n")

if _name_ == "_main_":  
    gen_tb_with_intf()
    

