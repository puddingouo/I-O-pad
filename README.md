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

## 2026-08-26
- 要點：整理並完成 CHIP.v、IO file（chip.io）、以及 IO file generator 的 skill/流程文件，確認目前 pad 寫法與 .io 格式具備可延續的基礎。
- 成果：
  - 完成 top wrapper 檔案 CHIP.v，已準備 input/output pad 實例化與核心連接。
  - 完成 IO file 範例 chip.io，包含 N/E/S/W 四邊 pad 排列與 corner/power 配置。
  - 補齊 IO File Generator skill 文件，整理規範、必要輸入、格式與設計原則。
  - 建立 pad planning SOP 的可重用文件，方便後續在新設計中套用。
- 阻礙：目前仍需確認 Databook 檔案的開啟方式，檢查 Databook 中實際 pad cell 名稱與 Innovus 產生 .io 的細節是否完全符合流片庫定義；另外檢查 pad 配置與命名是否與實際 netlist 一致。
- 待辦：
  1. 開啟 Innovus，確認環境與 library 設定是否正確。
  2. 以 chip.io / CHIP.v 進行實際 pad placement 檢查。
  3. 若 Innovus 讀入時有錯誤，回到 Databook 與 pad naming 進行修正。
