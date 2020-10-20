# Paper study

## Accurate Power control and monitoringin ZYNQ boards
[Link requires VPN access via TU Network](https://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=6927415)

Description of PMBus and of PSM and PLM Methods.

## Power Measurements and Analysis for DynamicCircuit Specialization
[Link requires VPN access via TU Network](https://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=7393336)

RT Measurement of CPU Power and FPGA silicon Area during Partial Reconfiguration. External board would be needed for measurements.

## Run-Time Power Gatingin Hybrid ARM-FPGA Devices
[Link requires VPN access via TU Network](https://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=6927503)

This Paper shows why rt-power measurent could be important --> power gating. to shut down specific areas and reduce for example leakage current. Implementation also utilizes PMBus over I2C. In conclusion this paper shows run-time software-controlled power gating technique applied to the Xilinx ZYNQ 

## Power Estimation and Power Measurement of Xilinx Virtex FPGAs: Trade-offs and Limitations 
[Link requires VPN access via TU Network](https://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=1232842)

Also focuses on reconfiguration.  XPower by Xilinx calculates power with the background   that   the   dynamic   powerconsumption  inside  CMOS  circuits  is  mainly  caused  byits switching activity. Measurement is done via external osci but maybe the TO DO gives hints to other good paper.

TO DO: *There  exist  many  approaches  for  the  analysis  and  estimation of the run-time power consumption of designson  FPGAs  and  they  have  been  able  to  derive  metricsenabling  the  designer  to  estimate  the  design’s  powerconsumption at design time [1], [2], [3], [11], [4], [6], [7],[8], [9], [10], [14], [15].*

## Run-time power and performance scaling in 28 nmFPGAs
[Link requires VPN access via TU Network](https://ieeexplore.ieee.org/stampPDF/getPDF.jsp?tp=&arnumber=6853134&ref=aHR0cHM6Ly9pZWVleHBsb3JlLmllZWUub3JnL2RvY3VtZW50LzY4NTMxMzQ=&tag=1)

Also working with PMBus over I2C. Measured Power is compared with Estimation via Xpower Analyzer. Maybe it would also be a method for the project to do an estimation, PMBus measurement and a measurement circuit of our own.

## Energy Optimization in Commercial FPGAs with Voltage, Frequency and Logic Scaling
[Link requires VPN access via TU Network](https://ieeexplore.ieee.org/document/7110584)

Same authors as *Run-time power and performance scaling in 28 nmFPGAs* just in more details



