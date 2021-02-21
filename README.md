# Introduction

This repo consists of a Vivado project which enables power monitoring of a VHDL module during execution.
The hardware in use is the ZedBoard.

## Developers

* Daniel Aspodinger
* Patrick Himler
* Paul Unfried
* Lukas Vogl

# Design Under Test

For the proof-of-concept a AES encryption/decryption module is used. (Source: https://github.com/jasonrtsang/zedboard_aes)

# Power Monitoring

Power monitoring is done by extracting indicative signals from the Design Under Test (DUT).
These signals are connected to the "pwr-mon" module which counts the falling and rising edges of those signals.

The measured values are flushed to UART in a periodic manner. As a output format CSV is used.

CSV-data is then picked up by the Excel-tool which provides a diagram of the measured values.

## Block diagram

![Blockdiagram](blockdiagramm.png)
