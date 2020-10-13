# Notes by me

Proposal: build-time analysis (by some refernce-tool) vs. run-time measurements

Frequency scaling

Without any means to measure current/voltage -> how to know which block needs what? -> Only estimation using model is applicable -> IP needs to provide information about internals

# Paper study

## Decision Tree Based Hardware Power Monitoring for Run Time Dynamic Power Management in FPGA

* Website: https://arxiv.org/pdf/2009.01434.pdf
* Last accessed: 13. Oct. 2020

Very promising paper for our project.
Abstract promises basically the same as discussed in the zoom-session.

"Light-weight and in-situ HW realization of the power monitoring scheme, including activity counters and an area-efficient memory-based decision tree with small overheads of power, performance and resource."

Also focuses on "non-linear dynamic power models in FPGA" (which is of less interest for us)

Quite unclear to me how the power measurement takes place?

Some kind of activity monitor + machine learning to have a fast model?


## An Ensemble Learning Approach for In-situ Monitoring of FPGA Dynamic Power

* Website: https://arxiv.org/pdf/2009.01432.pdf
* Last accessed: 13. Oct. 2020

"One possiblity is to use dedicated power measurement devices in the FPGA" -> can only measure in ~ms range -> too slow

Nearly same as above

## A Design-Time Method for Building Cost-Effective Run-Time Power Monitoring

(NEED TO ACCESS!)

* Website: https://ieeexplore.ieee.org/document/7579225
