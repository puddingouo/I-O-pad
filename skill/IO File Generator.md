# Skill: Innovus IO File Generator

**目的**：根據提供的 Gate-level Netlist、`io.tdf` 與物理單元宣告檔，自動生成符合 APR (Innovus) 規範且具備良好訊號完整性的 `.io` 檔案。

**必備輸入資訊**：
1. **Gate-level Netlist (CHIP.v)**：包含 Pad 實例化資訊，用於確認 Input/Output 訊號名稱與腳位對應。
2. **Physical Cell 宣告檔 (create_phy_cell.tcl)**：包含 Core Power、IO Power、Corner 與 POC Pad 的名稱、數量與 Cell Type 宣告。
3. **約束檔 (io.tdf)**：包含各個 Pad 在 N、E、S、W 四個邊的排列順序（Order）與間距設計。

**關鍵擺放原則（遵循 IO File Design 規範）**：
1. **Core Power 對稱性**：Core Power (`core_vdd`, `core_vss`) 必須在 N 與 S、W 與 E 兩兩對稱擺放，以利後續 Power Plan 階段佈建 Power Stripe。Core power 總數應維持偶數。
2. **關鍵訊號置中與隔離**：時脈 (clk)、重置 (rst_n) 與關鍵控制訊號需置於晶片四邊的中段以平均走線長度，且兩側必須緊鄰 Power Pad（例如排列為 `io_vdd - clk - io_vss`）以隔離高頻干擾。
3. **Power 與 IO 比例**：維持「至少 8 根訊號 IO 搭配 1 根 Power IO」的比例，以穩定輸出電容值的影響。若有多餘位置，優先分配給 VSS。
4. **格式與防呆檢查**：
   * 排除字元混淆錯誤（如數字 `0` 與字母 `O`）。
   * 確保每一根 Pad 在 Netlist 與 IO file 中的命名完全一致。
   * 確認 Corner Pad 分配至 NW, NE, SE, SW。

**輸出格式規範**：
請嚴格遵循 Innovus `.io` 檔案格式，一般訊號腳位僅需填寫名稱與方向，Power/Corner/POC 腳位需額外標註 Cell Type：
```text
Version : 1

Pad : [Corner_Name]  [Direction(NW/NE/SE/SW)]  [Cell_Type]
Pad : [Pad_Name]     [Side(N/E/S/W)]           [Cell_Type]
Pad : [Signal_Pad]   [Side(N/E/S/W)]