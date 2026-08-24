# ==========================================================================
# Script: create_phy_cell.tcl
# ==========================================================================

# 1. Core Power Pad (各 4 個)
set CORE_POWER_LIST  [list core_vdd1 core_vdd2 core_vdd3 core_vdd4]
set CORE_GROUND_LIST [list core_vss1 core_vss2 core_vss3 core_vss4]

# 2. IO Power Pad (15 個 VDD, 16 個 VSS)
set PAD_POWER_LIST   [list io_vdd1 io_vdd2 io_vdd3 io_vdd4 io_vdd5 \
                           io_vdd6 io_vdd7 io_vdd8 io_vdd9 io_vdd10 \
                           io_vdd11 io_vdd12 io_vdd13 io_vdd14 io_vdd15]
set PAD_GROUND_LIST  [list io_vss1 io_vss2 io_vss3 io_vss4 io_vss5 \
                           io_vss6 io_vss7 io_vss8 io_vss9 io_vss10 \
                           io_vss11 io_vss12 io_vss13 io_vss14 io_vss15 \
                           io_vss16]

# 3. Corner Pad (4 個)
set CORNER_LIST      [list cornerUL cornerUR cornerLR cornerLL]

# 4. POC Pad (1 個)
set POC_LIST         [list io_poc1]

# ==========================================================================
# 實例化 Pad Cells (請確認 PVDD1DGZ 等名稱與您的 T18 製程 Databook 一致)
# ==========================================================================
create_cell $CORE_POWER_LIST  PVDD1DGZ
create_cell $CORE_GROUND_LIST PVSS1DGZ
create_cell $PAD_POWER_LIST   PVDD2DGZ
create_cell $PAD_GROUND_LIST  PVSS2DGZ
create_cell $CORNER_LIST      PCORNER  #Corner Cell的名稱在上述的IO Pad文件中找不到，可以利用File > Open Design選擇IO Library(tpznXXXX)後從裡面找
create_cell $POC_LIST         PVDD2POC