# I-O-pad
數位 IC Pad 規劃與腳本撰寫 SOP

# 工作日記

## 2026-08-24
- 要點：跑過一次計算 IO pad 數量流程並整理相關腳本（create_phy_cell.tcl / io.tdf）。
- 成果：把流程與筆記包裝成 io_pad_skill.md 以方便日後重複使用。
- 阻礙：Databook (`DB_TPZN...`) 檔案在 CAD 路徑下無法開啟或存取（路徑：/cad/CBDK/.../CIC/doc），需確認開檔方式或取得正確檔案。
- 待辦：
  1. 確認 Databook 中 PVDD/PVSS 等 cell 實際名稱，並更新 create_phy_cell.tcl。
  2. 以 CHIP.v 包裝 top_module（目前尚未完成）。
  3. 人工檢查 create_phy_cell.tcl 與 io.tdf 的正確性（目前由 AI 產出為草稿）。

