
Q
Command: %s
53*	vivadotcl2 
route_design2default:defaultZ4-113h px� 
�
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2"
Implementation2default:default2
xc7z0202default:defaultZ17-347h px� 
�
0Got license for feature '%s' and/or device '%s'
310*common2"
Implementation2default:default2
xc7z0202default:defaultZ17-349h px� 
p
,Running DRC as a precondition to command %s
22*	vivadotcl2 
route_design2default:defaultZ4-22h px� 
P
Running DRC with %s threads
24*drc2
22default:defaultZ23-27h px� 
V
DRC finished with %s
79*	vivadotcl2
0 Errors2default:defaultZ4-198h px� 
e
BPlease refer to the DRC report (report_drc) for more information.
80*	vivadotclZ4-199h px� 
V

Starting %s Task
103*constraints2
Routing2default:defaultZ18-103h px� 
}
BMultithreading enabled for route_design using a maximum of %s CPUs17*	routeflow2
22default:defaultZ35-254h px� 
p

Phase %s%s
101*constraints2
1 2default:default2#
Build RT Design2default:defaultZ18-101h px� 
B
-Phase 1 Build RT Design | Checksum: 9e4bef4d
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:00:59 ; elapsed = 00:00:28 . Memory (MB): peak = 2150.141 ; gain = 94.0702default:defaulth px� 
v

Phase %s%s
101*constraints2
2 2default:default2)
Router Initialization2default:defaultZ18-101h px� 
o

Phase %s%s
101*constraints2
2.1 2default:default2 
Create Timer2default:defaultZ18-101h px� 
A
,Phase 2.1 Create Timer | Checksum: 9e4bef4d
*commonh px� 
�

%s
*constraints2q
]Time (s): cpu = 00:01:00 ; elapsed = 00:00:28 . Memory (MB): peak = 2176.422 ; gain = 120.3522default:defaulth px� 
{

Phase %s%s
101*constraints2
2.2 2default:default2,
Fix Topology Constraints2default:defaultZ18-101h px� 
M
8Phase 2.2 Fix Topology Constraints | Checksum: 9e4bef4d
*commonh px� 
�

%s
*constraints2q
]Time (s): cpu = 00:01:00 ; elapsed = 00:00:29 . Memory (MB): peak = 2183.586 ; gain = 127.5162default:defaulth px� 
t

Phase %s%s
101*constraints2
2.3 2default:default2%
Pre Route Cleanup2default:defaultZ18-101h px� 
F
1Phase 2.3 Pre Route Cleanup | Checksum: 9e4bef4d
*commonh px� 
�

%s
*constraints2q
]Time (s): cpu = 00:01:00 ; elapsed = 00:00:29 . Memory (MB): peak = 2183.586 ; gain = 127.5162default:defaulth px� 
p

Phase %s%s
101*constraints2
2.4 2default:default2!
Update Timing2default:defaultZ18-101h px� 
B
-Phase 2.4 Update Timing | Checksum: c2f35d1c
*commonh px� 
�

%s
*constraints2q
]Time (s): cpu = 00:01:13 ; elapsed = 00:00:38 . Memory (MB): peak = 2218.648 ; gain = 162.5782default:defaulth px� 
�
Intermediate Timing Summary %s164*route2M
9| WNS=-26.714| TNS=-9477.317| WHS=-0.301 | THS=-261.832|
2default:defaultZ35-416h px� 
H
3Phase 2 Router Initialization | Checksum: e83f6992
*commonh px� 
�

%s
*constraints2q
]Time (s): cpu = 00:01:20 ; elapsed = 00:00:43 . Memory (MB): peak = 2235.195 ; gain = 179.1252default:defaulth px� 
p

Phase %s%s
101*constraints2
3 2default:default2#
Initial Routing2default:defaultZ18-101h px� 
C
.Phase 3 Initial Routing | Checksum: 1e5b6cce7
*commonh px� 
�

%s
*constraints2q
]Time (s): cpu = 00:01:29 ; elapsed = 00:00:48 . Memory (MB): peak = 2236.148 ; gain = 180.0782default:defaulth px� 
�
>Design has %s pins with tight setup and hold constraints.

%s
244*route2
432default:default2�
�The top 5 pins with tight setup and hold constraints:

+--------------------------+--------------------------+----------------------------------------------------------------------------------------------------------+
|       Launch Clock       |      Capture Clock       |                                                 Pin                                                      |
+--------------------------+--------------------------+----------------------------------------------------------------------------------------------------------+
|               clk_fpga_0 |               clk_fpga_0 |                                    system_i/AES_PROCESS_0/U0/aes/generate_first_state/s_addRoundKey_reg/D|
|               clk_fpga_0 |               clk_fpga_0 |                                                   system_i/AES_PROCESS_0/U0/aes/curr_state_reg[0][1][5]/D|
|               clk_fpga_0 |               clk_fpga_0 |                                                   system_i/AES_PROCESS_0/U0/aes/curr_state_reg[0][3][4]/D|
|               clk_fpga_0 |               clk_fpga_0 |                                                   system_i/AES_PROCESS_0/U0/aes/curr_state_reg[0][1][0]/D|
|               clk_fpga_0 |               clk_fpga_0 |                                                     system_i/AES_PROCESS_0/U0/aes/curr_key_reg[3][0][7]/D|
+--------------------------+--------------------------+----------------------------------------------------------------------------------------------------------+

File with complete list of pins: tight_setup_hold_pins.txt
2default:defaultZ35-580h px� 
s

Phase %s%s
101*constraints2
4 2default:default2&
Rip-up And Reroute2default:defaultZ18-101h px� 
u

Phase %s%s
101*constraints2
4.1 2default:default2&
Global Iteration 02default:defaultZ18-101h px� 
�
Intermediate Timing Summary %s164*route2M
9| WNS=-33.084| TNS=-16758.329| WHS=N/A    | THS=N/A    |
2default:defaultZ35-416h px� 
H
3Phase 4.1 Global Iteration 0 | Checksum: 1ad18f068
*commonh px� 
�

%s
*constraints2q
]Time (s): cpu = 00:02:54 ; elapsed = 00:01:41 . Memory (MB): peak = 2240.965 ; gain = 184.8952default:defaulth px� 
u

Phase %s%s
101*constraints2
4.2 2default:default2&
Global Iteration 12default:defaultZ18-101h px� 
�
Intermediate Timing Summary %s164*route2M
9| WNS=-33.595| TNS=-17002.913| WHS=N/A    | THS=N/A    |
2default:defaultZ35-416h px� 
G
2Phase 4.2 Global Iteration 1 | Checksum: fe968705
*commonh px� 
�

%s
*constraints2q
]Time (s): cpu = 00:04:00 ; elapsed = 00:02:25 . Memory (MB): peak = 2240.965 ; gain = 184.8952default:defaulth px� 
E
0Phase 4 Rip-up And Reroute | Checksum: fe968705
*commonh px� 
�

%s
*constraints2q
]Time (s): cpu = 00:04:00 ; elapsed = 00:02:25 . Memory (MB): peak = 2240.965 ; gain = 184.8952default:defaulth px� 
|

Phase %s%s
101*constraints2
5 2default:default2/
Delay and Skew Optimization2default:defaultZ18-101h px� 
p

Phase %s%s
101*constraints2
5.1 2default:default2!
Delay CleanUp2default:defaultZ18-101h px� 
r

Phase %s%s
101*constraints2
5.1.1 2default:default2!
Update Timing2default:defaultZ18-101h px� 
E
0Phase 5.1.1 Update Timing | Checksum: 117fcfd92
*commonh px� 
�

%s
*constraints2q
]Time (s): cpu = 00:04:03 ; elapsed = 00:02:28 . Memory (MB): peak = 2240.965 ; gain = 184.8952default:defaulth px� 
�
Intermediate Timing Summary %s164*route2M
9| WNS=-32.936| TNS=-16624.899| WHS=N/A    | THS=N/A    |
2default:defaultZ35-416h px� 
C
.Phase 5.1 Delay CleanUp | Checksum: 1e8d4bd37
*commonh px� 
�

%s
*constraints2q
]Time (s): cpu = 00:04:09 ; elapsed = 00:02:31 . Memory (MB): peak = 2249.023 ; gain = 192.9532default:defaulth px� 
z

Phase %s%s
101*constraints2
5.2 2default:default2+
Clock Skew Optimization2default:defaultZ18-101h px� 
M
8Phase 5.2 Clock Skew Optimization | Checksum: 1e8d4bd37
*commonh px� 
�

%s
*constraints2q
]Time (s): cpu = 00:04:10 ; elapsed = 00:02:31 . Memory (MB): peak = 2249.023 ; gain = 192.9532default:defaulth px� 
O
:Phase 5 Delay and Skew Optimization | Checksum: 1e8d4bd37
*commonh px� 
�

%s
*constraints2q
]Time (s): cpu = 00:04:10 ; elapsed = 00:02:31 . Memory (MB): peak = 2249.023 ; gain = 192.9532default:defaulth px� 
n

Phase %s%s
101*constraints2
6 2default:default2!
Post Hold Fix2default:defaultZ18-101h px� 
p

Phase %s%s
101*constraints2
6.1 2default:default2!
Hold Fix Iter2default:defaultZ18-101h px� 
r

Phase %s%s
101*constraints2
6.1.1 2default:default2!
Update Timing2default:defaultZ18-101h px� 
E
0Phase 6.1.1 Update Timing | Checksum: 21615e77f
*commonh px� 
�

%s
*constraints2q
]Time (s): cpu = 00:04:13 ; elapsed = 00:02:33 . Memory (MB): peak = 2249.023 ; gain = 192.9532default:defaulth px� 
�
Intermediate Timing Summary %s164*route2M
9| WNS=-32.652| TNS=-16516.498| WHS=0.012  | THS=0.000  |
2default:defaultZ35-416h px� 
C
.Phase 6.1 Hold Fix Iter | Checksum: 1c793aff1
*commonh px� 
�

%s
*constraints2q
]Time (s): cpu = 00:04:13 ; elapsed = 00:02:33 . Memory (MB): peak = 2249.023 ; gain = 192.9532default:defaulth px� 
A
,Phase 6 Post Hold Fix | Checksum: 1c793aff1
*commonh px� 
�

%s
*constraints2q
]Time (s): cpu = 00:04:13 ; elapsed = 00:02:33 . Memory (MB): peak = 2249.023 ; gain = 192.9532default:defaulth px� 
o

Phase %s%s
101*constraints2
7 2default:default2"
Route finalize2default:defaultZ18-101h px� 
B
-Phase 7 Route finalize | Checksum: 13e7d04ca
*commonh px� 
�

%s
*constraints2q
]Time (s): cpu = 00:04:13 ; elapsed = 00:02:34 . Memory (MB): peak = 2249.023 ; gain = 192.9532default:defaulth px� 
v

Phase %s%s
101*constraints2
8 2default:default2)
Verifying routed nets2default:defaultZ18-101h px� 
I
4Phase 8 Verifying routed nets | Checksum: 13e7d04ca
*commonh px� 
�

%s
*constraints2q
]Time (s): cpu = 00:04:13 ; elapsed = 00:02:34 . Memory (MB): peak = 2249.023 ; gain = 192.9532default:defaulth px� 
r

Phase %s%s
101*constraints2
9 2default:default2%
Depositing Routes2default:defaultZ18-101h px� 
D
/Phase 9 Depositing Routes | Checksum: f8842743
*commonh px� 
�

%s
*constraints2q
]Time (s): cpu = 00:04:16 ; elapsed = 00:02:37 . Memory (MB): peak = 2249.023 ; gain = 192.9532default:defaulth px� 
t

Phase %s%s
101*constraints2
10 2default:default2&
Post Router Timing2default:defaultZ18-101h px� 
�
Estimated Timing Summary %s
57*route2M
9| WNS=-32.652| TNS=-16516.498| WHS=0.012  | THS=0.000  |
2default:defaultZ35-57h px� 
B
!Router estimated timing not met.
128*routeZ35-328h px� 
F
1Phase 10 Post Router Timing | Checksum: f8842743
*commonh px� 
�

%s
*constraints2q
]Time (s): cpu = 00:04:16 ; elapsed = 00:02:37 . Memory (MB): peak = 2249.023 ; gain = 192.9532default:defaulth px� 
@
Router Completed Successfully
2*	routeflowZ35-16h px� 
�

%s
*constraints2q
]Time (s): cpu = 00:04:16 ; elapsed = 00:02:37 . Memory (MB): peak = 2249.023 ; gain = 192.9532default:defaulth px� 
Z
Releasing license: %s
83*common2"
Implementation2default:defaultZ17-83h px� 
�
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
962default:default2
102default:default2
172default:default2
02default:defaultZ4-41h px� 
^
%s completed successfully
29*	vivadotcl2 
route_design2default:defaultZ4-42h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2"
route_design: 2default:default2
00:04:212default:default2
00:02:402default:default2
2249.0232default:default2
197.6052default:defaultZ17-268h px� 
H
&Writing timing data to binary archive.266*timingZ38-480h px� 
D
Writing placer database...
1603*designutilsZ20-1893h px� 
=
Writing XDEF routing.
211*designutilsZ20-211h px� 
J
#Writing XDEF routing logical nets.
209*designutilsZ20-209h px� 
J
#Writing XDEF routing special nets.
210*designutilsZ20-210h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2)
Write XDEF Complete: 2default:default2
00:00:082default:default2
00:00:032default:default2
2249.0232default:default2
0.0002default:defaultZ17-268h px� 
�
 The %s '%s' has been generated.
621*common2

checkpoint2default:default2w
cC:/Uni/Labor-SoC-Design/zedboard_aes-master/power_monitor_aes.runs/impl_1/system_wrapper_routed.dcp2default:defaultZ17-1381h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2&
write_checkpoint: 2default:default2
00:00:132default:default2
00:00:092default:default2
2249.0232default:default2
0.0002default:defaultZ17-268h px� 
�
%s4*runtcl2�
Executing : report_drc -file system_wrapper_drc_routed.rpt -pb system_wrapper_drc_routed.pb -rpx system_wrapper_drc_routed.rpx
2default:defaulth px� 
�
Command: %s
53*	vivadotcl2�
rreport_drc -file system_wrapper_drc_routed.rpt -pb system_wrapper_drc_routed.pb -rpx system_wrapper_drc_routed.rpx2default:defaultZ4-113h px� 
>
IP Catalog is up to date.1232*coregenZ19-1839h px� 
P
Running DRC with %s threads
24*drc2
22default:defaultZ23-27h px� 
�
#The results of DRC are in file %s.
168*coretcl2�
gC:/Uni/Labor-SoC-Design/zedboard_aes-master/power_monitor_aes.runs/impl_1/system_wrapper_drc_routed.rptgC:/Uni/Labor-SoC-Design/zedboard_aes-master/power_monitor_aes.runs/impl_1/system_wrapper_drc_routed.rpt2default:default8Z2-168h px� 
\
%s completed successfully
29*	vivadotcl2

report_drc2default:defaultZ4-42h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2 
report_drc: 2default:default2
00:00:102default:default2
00:00:052default:default2
2262.5042default:default2
13.4802default:defaultZ17-268h px� 
�
%s4*runtcl2�
�Executing : report_methodology -file system_wrapper_methodology_drc_routed.rpt -pb system_wrapper_methodology_drc_routed.pb -rpx system_wrapper_methodology_drc_routed.rpx
2default:defaulth px� 
�
Command: %s
53*	vivadotcl2�
�report_methodology -file system_wrapper_methodology_drc_routed.rpt -pb system_wrapper_methodology_drc_routed.pb -rpx system_wrapper_methodology_drc_routed.rpx2default:defaultZ4-113h px� 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px� 
Y
$Running Methodology with %s threads
74*drc2
22default:defaultZ23-133h px� 
�
2The results of Report Methodology are in file %s.
450*coretcl2�
sC:/Uni/Labor-SoC-Design/zedboard_aes-master/power_monitor_aes.runs/impl_1/system_wrapper_methodology_drc_routed.rptsC:/Uni/Labor-SoC-Design/zedboard_aes-master/power_monitor_aes.runs/impl_1/system_wrapper_methodology_drc_routed.rpt2default:default8Z2-1520h px� 
d
%s completed successfully
29*	vivadotcl2&
report_methodology2default:defaultZ4-42h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2(
report_methodology: 2default:default2
00:00:192default:default2
00:00:112default:default2
2328.8872default:default2
66.3832default:defaultZ17-268h px� 
�
%s4*runtcl2�
�Executing : report_power -file system_wrapper_power_routed.rpt -pb system_wrapper_power_summary_routed.pb -rpx system_wrapper_power_routed.rpx
2default:defaulth px� 
�
Command: %s
53*	vivadotcl2�
�report_power -file system_wrapper_power_routed.rpt -pb system_wrapper_power_summary_routed.pb -rpx system_wrapper_power_routed.rpx2default:defaultZ4-113h px� 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px� 
K
,Running Vector-less Activity Propagation...
51*powerZ33-51h px� 
P
3
Finished Running Vector-less Activity Propagation
1*powerZ33-1h px� 
�
�Detected over-assertion of set/reset/preset/clear net with high fanouts, power estimation might not be accurate. Please run Tool - Power Constraint Wizard to set proper switching activities for control signals.282*powerZ33-332h px� 
�
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
1082default:default2
112default:default2
172default:default2
02default:defaultZ4-41h px� 
^
%s completed successfully
29*	vivadotcl2 
report_power2default:defaultZ4-42h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2"
report_power: 2default:default2
00:00:182default:default2
00:00:122default:default2
2331.1452default:default2
2.2582default:defaultZ17-268h px� 
�
%s4*runtcl2}
iExecuting : report_route_status -file system_wrapper_route_status.rpt -pb system_wrapper_route_status.pb
2default:defaulth px� 
�
%s4*runtcl2�
�Executing : report_timing_summary -max_paths 10 -file system_wrapper_timing_summary_routed.rpt -pb system_wrapper_timing_summary_routed.pb -rpx system_wrapper_timing_summary_routed.rpx -warn_on_violation 
2default:defaulth px� 
r
UpdateTimingParams:%s.
91*timing29
% Speed grade: -1, Delay Type: min_max2default:defaultZ38-91h px� 
|
CMultithreading enabled for timing update using a maximum of %s CPUs155*timing2
22default:defaultZ38-191h px� 
�
rThe design failed to meet the timing requirements. Please see the %s report for details on the timing violations.
188*timing2"
timing summary2default:defaultZ38-282h px� 
�
%s4*runtcl2k
WExecuting : report_incremental_reuse -file system_wrapper_incremental_reuse_routed.rpt
2default:defaulth px� 
g
BIncremental flow is disabled. No incremental reuse Info to report.423*	vivadotclZ4-1062h px� 
�
%s4*runtcl2k
WExecuting : report_clock_utilization -file system_wrapper_clock_utilization_routed.rpt
2default:defaulth px� 


End Record