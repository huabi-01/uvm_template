import sys
import os
import argparse
import logging as log
import shutil
from helper import try_mkdir,gen_template_text,run_in,read_yaml
from helper import write_file,run_one_line_cmd

"""
    Command line tool to generate DV testbench
"""

def arg_parse():
    arg_parser = argparse.ArgumentParser()

    arg_parser.add_argument(
            "name",
            metavar="[ip/block name]",
            help="Name of the ip/block for which the uvm tb is being generated"
            )
    arg_parser.add_argument(
            "-gen_agt",
            choices=["master","slave"],
            required=True,
            help="Generate uvm agent code which can specify master or slave"
            )
    
    arg_parser.add_argument(
            "-gen_env",
            action="store_false",
            help="Generate uvm env code,default is not generated"
            )
    args = arg_parser.parse_args()
    return args

# Color constans for terminal
class TermColor:
    """ Terminal codes for printing in color """
    # pylint: disable=too-few-public-methods
    PURPLE = "\033[95m"
    BLUE = "\033[94m"
    GREEN = "\033[92m"
    YELLOW = "\033[93m"
    RED = "\033[91m"
    END = "\033[0m"
    BOLD = "\033[1m"
    UNDERLINE = "\033[4m"


# Print message to console with a color
def print_color(color, *msg):
    """ Print a message in color """
    print(color + " ".join(str(item) for item in msg), TermColor.END)


def main():
    args = arg_parse() 
    name = args.name
    agt_type = args.gen_agt
    is_gen_env = args.gen_env
    
    ### Generate driver code
    tb_comp_tmpl_list = ["driver.sv","monitor.sv","sequencer.sv","agent.sv","sequence_lib.sv","transaction.sv","pkg.sv"]
    for tb_comp_tmpl in tb_comp_tmpl_list:
        comp_file_name = name+"_"+agt_type+"_"+tb_comp_tmpl
        gen_template_text(
                comp_file_name,
                tb_comp_tmpl,
                dict( name = name,
                      type = agt_type
                     ),
                template_root_dir="/home/ICer/software/exe/uvmdvgen/tmpl/tb",
                x = False
                )

    if is_gen_env:
        tb_env_list = ["transaction.sv","sequence_lib.sv","env.sv","test.sv"]
        
if __name__ == "__main__":
    main()

