#! /usr/bin/env python

#if on linux, convert command has to be installed before exec this script
#convert is contained in ImageMagick package

import os

def main():
    dir_list = os.listdir('.')
    for full_file_name in dir_list:
        base_name, extension = os.path.splitext(full_file_name)
        if extension == '.pdf': # then .pdf file --> convert to image!
            cmd_str = ' '.join(['convert',
                                '-density 200',
                                full_file_name,
                                base_name + '.png'])
            print(cmd_str)  # echo command to terminal
            os.system(cmd_str)  # execute command

if __name__ == '__main__':
    main()
