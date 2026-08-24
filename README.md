# I-O-pad
數位 IC Pad 規劃與腳本撰寫 SOP

工作日記:
2026/8/24 
  跑過一次計算io pad數量的流程與.tcl、.tdf之撰寫，對應[皓宇的筆記-io pad的選擇]章節，
  將過程請 ai 包裝成 io_pad_skill.md 已方便日後使用
  目前問題:
    1./cad/CBDK/CBDK_TN40G_Arm/CBDK_TSMC40_io_TSMC_v2.0/CIC/doc 路徑內的 DB 檔案大多無法開啟(不確定是否開啟方式錯誤),因此無法確定使用的元件是否全部存在
    2.top_module 還沒有重新包裝，明天再說
    3.create_phy_cell.tcl、io.tdf 是由ai排的，正確性還需確認
