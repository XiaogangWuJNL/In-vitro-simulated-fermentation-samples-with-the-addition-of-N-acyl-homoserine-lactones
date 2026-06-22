setwd("D:/R/file/AHL_12samples/CAG_Metabonomics_heatmap")
library(pheatmap)
library(grid)  

# 读取数据
data <- read.table("R.txt", header = T, row.names = 1, sep = "\t")
pval <- read.table("P.txt", header = T, row.names = 1, sep = "\t")

# 创建显著性标记矩阵
label <- matrix("", nrow = 20, ncol = 18)
label[which(pval < 0.05)] <- "*"
label[which(pval < 0.01)] <- "**"
label[which(pval < 0.001)] <- "***"

# 设置颜色范围断点
breaks <- seq(-1, 1, length.out = 100)

# ========== 修改1：自定义配色（低值绿色、高值紫色，匹配环状热图风格） ==========
# 渐变逻辑：深绿(R=-1) → 浅绿 → 浅黄(R=0) → 浅紫 → 深紫(R=1)
my_colors <- colorRampPalette(c('#00B554', 'white', '#B586CA'))(length(breaks)-1)

# 生成热图
b <- pheatmap(data,
              cluster_rows = F,
              cluster_cols = T,
              display_numbers = label,
              cellwidth = 15,
              cellheight = 15,
              fontsize = 10,
              # ========== 修改2：显著性星号加粗+微调字号，更醒目 ==========
              fontsize_number = 12,       # 字号从7微调至8，放大标记
              fontface_number = "bold",  # 字体设置为粗体，*号更突出
              breaks = breaks,
              color = my_colors,         # 应用自定义绿紫配色
              legend_breaks = c(-1, -0.5, 0, 0.5, 1),
              legend_labels = c("-1", "-0.5", "0", "0.5", "1"))

# 保存图片
jpeg(file = "18CAG_meta.jpeg", height = 1700, width = 1700, res = 300)

print(b)

# 添加 "R value" 标题（位置、样式完全保留）
grid.text("R value", x = unit(0.91, "npc"), y = unit(0.88, "npc"), 
          gp = gpar(fontsize = 10))

dev.off()