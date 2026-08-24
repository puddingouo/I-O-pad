---
title: "Layout Pre-sim — Physical Design Stage"
source_doc: "layout_presim流程(2)_Physical Design階段.docx"
---

# Layout Pre-sim — Physical Design Stage

以booth radix4 為top_module 為例

- **訊號腳位 (68 個)**：35 個 Input Pad + 33 個 Output Pad

- **IO 電源 (32 個)**：15 個 IO VDD + 16 個 IO VSS + 1 個 POC

- **Core 電源 (8 個)**：4 個 Core VDD + 4 個 Core VSS

- **角落腳位 (4 個)**：4 個 Corner Pad

### 一、 修改 Top Module (實例化 Signal Pad)

在進入佈局繞線（P&R）軟體之前，通常會先在硬體描述語言中把訊號腳位接好。

- **修改 Verilog**：在您的頂層模組（例如 CHIP.v）中，直接將那 17 個
  PDO16CDG Output Pad 以及其他需要的 Input Pad
  實例化（Instantiate）進去，並與加速器的核心電路正確連接。

還未進行

### 二、 撰寫 create_phy_cell.tcl (產生 Power Pad)

Signal Pad 在 Verilog 中寫好後，剩下的 Power Pad 與 Corner Pad 則交由
P&R 工具（如 IC Compiler）透過腳本產生。

- **定義清單**：將計算好的 Pad 分別命名並整理成 List。

- **建立 Cell**：使用 create_cell 指令，將您命名的 Pad
  綁定到製程資料庫中對應的真實 Cell 名稱（例如 PVDD1DGZ、PVDD2DGZ 等）。

參考資料夾code內檔案

### 三、 規劃 io.tdf 檔 (決定 Pad 實體位置)

這是最需要花心思規劃的一步，您必須決定所有 Pad 在晶片四個邊（Side 1 ~
Side 4）的排列順序，並遵守以下擺放規則：

- **平衡與穿插**：IO Power Pad (VDD/VSS)
  需盡量平均分配在四邊並交錯擺放。如果某一個邊放了特別多 Output
  Pad，該邊就要配置多一點的 IO Power Pad。

- **隔離 Core Power**：Core VDD Pad
  的兩側建議**不要**緊貼訊號腳位（Signal Pad），可以利用 Core VSS 或 IO
  Power Pad 來將它們隔開，以維持供電穩定。

- **預留打線間距**：在腳本中設定相鄰 Pad 的最小間距（如
  -min_left_iospace 設為 5~10 \$\mu
  m\$），避免未來封裝打線（Bonding）時發生 DRC 違例。

> 參考資料夾code內檔案