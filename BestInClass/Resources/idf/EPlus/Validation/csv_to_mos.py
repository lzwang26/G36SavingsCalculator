#!/usr/bin/env python3
import sys
import energyplus_csv_to_mos as e

def check():
    args = sys.argv[1:]
    dat_fil = args[0].replace(".idf", ".dat")
    print(dat_fil)

def main():
    args = sys.argv[1:]
    dat_fil = args[0].replace(".idf", ".dat")
    output_list =[
    'Environment:Site Outdoor Air Drybulb Temperature [C](TimeStep)',
      '21 ZONE PVAV SUPPLY OUTLET NODE:System Node Temperature [C](TimeStep)',
      '21 ZONE PVAV SUPPLY OUTLET NODE:System Node Mass Flow Rate [kg/s](TimeStep)',
      '21 ZONE PVAV OUTDOOR AIR NODE:System Node Mass Flow Rate [kg/s](TimeStep)',
      '21 ZONE PVAV 2SPD DX CLG COIL 328KBTU/HR 9.8EER:Cooling Coil Total Cooling Rate [W](TimeStep)',
      '21 ZONE PVAV SUPPLY INLET NODE:System Node Temperature [C](TimeStep)',
      'ACTIVESTORAGE_MID_1 ZN:Zone Air Temperature [C](TimeStep)',
      'ACTIVESTORAGE_MID_2 ZN:Zone Air Temperature [C](TimeStep)',
      'ACTIVESTORAGE_MID_3 ZN:Zone Air Temperature [C](TimeStep)',
      'ACTIVESTORAGE_MID_4 ZN:Zone Air Temperature [C](TimeStep)',
      'CONFROOM_MID_1 ZN:Zone Air Temperature [C](TimeStep)',
      'CONFROOM_MID_2 ZN:Zone Air Temperature [C](TimeStep)',
      'CORRIDOR_MID_1 ZN:Zone Air Temperature [C](TimeStep)',
      'CORRIDOR_MID_2 ZN:Zone Air Temperature [C](TimeStep)',
      'DINING_MID ZN:Zone Air Temperature [C](TimeStep)',
      'ENCLOSEDOFFICE_MID_1 ZN:Zone Air Temperature [C](TimeStep)',
      'ENCLOSEDOFFICE_MID_2 ZN:Zone Air Temperature [C](TimeStep)',
      'ENCLOSEDOFFICE_MID_3 ZN:Zone Air Temperature [C](TimeStep)',
      'LOBBY_MID ZN:Zone Air Temperature [C](TimeStep)',
      'MECHANICAL_MID ZN:Zone Air Temperature [C](TimeStep)',
      'OPENOFFICE_MID_1 ZN:Zone Air Temperature [C](TimeStep)',
      'OPENOFFICE_MID_2 ZN:Zone Air Temperature [C](TimeStep)',
      'OPENOFFICE_MID_3 ZN:Zone Air Temperature [C](TimeStep)',
      'OPENOFFICE_MID_4 ZN:Zone Air Temperature [C](TimeStep)',
      'RESTROOM_MID ZN:Zone Air Temperature [C](TimeStep)',
      'STAIR_MID_1 ZN:Zone Air Temperature [C](TimeStep)',
      'STAIR_MID_2 ZN:Zone Air Temperature [C](TimeStep)',
      'MIDFLOOR_PLENUM ZN:Zone Air Temperature [C](TimeStep)'
    ]

    e.energyplus_csv_to_mos(
    output_list = output_list,
    dat_file_name=dat_fil,
    start_time=16329600,
    step_size=60,
    final_time=16761600)

if __name__ == '__main__':
    main()
