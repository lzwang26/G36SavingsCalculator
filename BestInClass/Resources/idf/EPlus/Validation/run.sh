#!/bin/bash
set -e
set -x  # Enable debug mode to print each command as it's executed

mkdir -p EnergyPlus

idf_file=`ls *.idf`

# Run EnergyPlus and redirect output to a log file in Windows
energyplus \
  --readvars \
  --output-directory EnergyPlus \
  -w USA_CA_Sacramento.Metro.AP.724839_TMY3.epw \
  "$idf_file" > EnergyPlus/run.log 2>&1

# Run the Python script and append its output to the same log file
python csv_to_mos.py "$idf_file" >> EnergyPlus/run.log 2>&1
