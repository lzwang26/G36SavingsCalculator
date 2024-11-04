#!/bin/bash
set -e
idf_file=`ls *.idf`
energyplus \
  --readvars \
  --output-directory EnergyPlus \
  -w USA_CA_Sacramento.Metro.AP.724839_TMY3.epw \
  "$idf_file"
python csv_to_mos.py "$idf_file"
#rm -rf EnergyPlus
