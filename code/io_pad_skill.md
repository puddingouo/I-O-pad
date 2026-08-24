這是一份為您整理的完整「數位 IC Pad 規劃與腳本撰寫 SOP」。您可以將這份流程視為一個標準化技能（Skill），未來在進行新的晶片實體佈局（Physical Design）時，只需依循這些步驟即可快速、正確地完成 Pad 的配置。

---

# 🛠️ 數位 IC Pad 規劃與腳本撰寫 SOP (TSRI 實務流程)

## 階段一：評估與計算 Pad 數量

在進入任何腳本撰寫前，必須先精算所需的所有 Pad 數量。Pad 主要分為四大類：訊號 (Signal)、IO 電源 (IO Power)、核心電源 (Core Power)、角落 (Corner)。

### 1. 決定 Signal Pad (訊號腳位)

* **Input Pad (如 `PDDDGZ`)**：數量等同於 Top Module 的輸入腳位總數。
* **Output Pad (如 `PDO16CDG`)**：數量等同於 Top Module 的輸出腳位總數。
* *規範與取捨*：選用推動力大（如 `PDO16CDG`, `PDO24CDG`）的 Pad 可減少量測時的訊號延遲，但代價是極度耗電，會增加大量的 IO Power Pad 面積。建議中庸選擇 `PDO12CDG` 或 `PDO16CDG`。



### 2. 計算 IO Power Pad (供應 IO Ring 電源)

依據所選的 Output Pad 種類與數量來計算：

1. 查閱 Databook 算出單一 Output Pad 的 **DF 值 (Driving Factor)**。
2. **DF 值總和** = (單一 DF 值) × (Output Pad 總數)。
3. **IO VDD 數量** = DF 值總和 ÷ 1.6 (無條件進位取整數)。
4. **IO VSS 數量** = DF 值總和 ÷ 1.5 (無條件進位取整數)。
5. **POC (Power-on Control)**：每個 Power Domain **必備且僅限 1 個**。

### 3. 評估 Core Power Pad (供應 Core Ring 電源)

依據全晶片的功耗（Power Analysis 報表）來計算：

1. **核心總電流** = Core Power (mW) ÷ Core VDD (如 T18 為 1.8V)。
2. **理論數量** = 核心總電流 ÷ (單一 Pad 最大電流上限，查閱 Release Note EM Table)。
3. **平衡擺放原則**：即使理論計算只需 1 組，實務上強烈建議在晶片的**四個邊各放 1 組**（即 4 個 Core VDD + 4 個 Core VSS），以維持內部供電穩定。

### 4. 加上 Corner Pad

* 晶片的四個角落必須各放 1 個 Corner Pad（共 4 個）以連接周圍的 Power Ring。

---

## 階段二：修改 Verilog 頂層模組 (Top Module)

> ⚠️ **極度重要注意事項**：
> 佈局軟體不會自動幫您把內部電路接上外部腳位。所有的**訊號腳位 (Signal Pad)** 必須在 Verilog 程式碼中手動實例化。

* **作法**：在您的頂層模組（如 `CHIP.v`）中，將所有 Input Pad 與 Output Pad 例置 (Instantiate) 出來，並正確連接到核心模組（如 `booth_radix4`）的對應接腳。
* **注意**：Core Power、IO Power、Corner、POC 等「純實體 Pad」**不需要**寫入 Verilog 中，這些交由下一步的腳本產生。

---

## 階段三：撰寫 `create_phy_cell.tcl`

此腳本的作用是讓 P&R 工具（如 IC Compiler）在環境中「無中生有」創造出 Verilog 沒寫的實體 Power/Corner Pad。

```tcl
# 1. 建立您自訂的名稱清單 (方便後續 io.tdf 呼叫)
set CORE_POWER_LIST  [list core_vdd1 core_vdd2 core_vdd3 core_vdd4]
set CORE_GROUND_LIST [list core_vss1 core_vss2 core_vss3 core_vss4]
# ...依此類推定義 PAD_POWER_LIST, PAD_GROUND_LIST, CORNER_LIST, POC_LIST

# 2. 將自訂名稱綁定製程 Databook 中的真實 Cell 名稱
create_cell $CORE_POWER_LIST  PVDD1DGZ
create_cell $CORE_GROUND_LIST PVSS1DGZ
create_cell $PAD_POWER_LIST   PVDD2DGZ
create_cell $PAD_GROUND_LIST  PVSS2DGZ
create_cell $CORNER_LIST      PCORNER
create_cell $POC_LIST         PVDD2POC

```

* **規範**：腳本下半部的 `PVDD1DGZ` 等名稱，務必開啟對應製程的 Databook (`DB_TPZN...`) 進行二次確認，不同製程命名可能不同。

---

## 階段四：撰寫 `io.tdf` (Pad 擺放與間距約束)

這是決定晶片實體外觀的最關鍵腳本，負責定義 Pad 在四個邊 (Side 1~4) 的排列順序與間距。

### 📝 嚴格遵守的佈局規範 (DRC 守則)

1. **絕對禁用 Tab 鍵**：TDF 檔對於空白格式非常敏感。排版對齊時**一律使用空白鍵 (Space)**，否則執行時極易引發未知錯誤。
2. **預留打線間距 (Bonding Space)**：利用變數設定 `set IO_SPACE 8.5` (建議值 5~10 $\mu m$)，並套用至 `-min_left_iospace` 與 `-min_right_iospace`，避免未來封裝打線時距離過近導致 DRC 違例。
3. **Core VDD 隔離原則**：Core VDD Pad 的兩側**絕對不可**緊貼 Signal Pad。必須使用 Core VSS 或 IO Power Pad 將其包夾隔離。
4. **電源均勻穿插**：IO VDD 與 IO VSS 應盡量在四個邊交錯擺放；若某一個邊的 Output Pad 特別多，該邊應配置較多的 IO Power Pad。
5. **封裝腳位對齊 (Dummy Pads)**：若選定特定封裝（如 CQFP128，每邊 32 腳），建議將每個邊用不到的空位以註解 `#` 的方式寫出，確保設計者精確掌握每個邊的腳位數量，避免後續封裝錯位。

**基本語法範例**：

```tcl
set_pad_physical_constraints -side 1 -pad_name cornerUL
set_pad_physical_constraints -side 1 -pad_name io_poc1 -order 1 -min_left_iospace $IO_SPACE -min_right_iospace $IO_SPACE

```