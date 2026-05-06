setwd("D:/R/file/AHL_12samples/CAG_SCFAs_heatmap")
library(pheatmap)
library(grid)  # 确保加载 grid 包

# 读取数据
data <- read.table("R.txt", header = T, row.names = 1, sep = "\t")
pval <- read.table("P.txt", header = T, row.names = 1, sep = "\t")

# 创建显著性标记矩阵
label <- matrix("", nrow = 8, ncol = 18)
label[which(pval < 0.05)] <- "*"
label[which(pval < 0.01)] <- "**"
label[which(pval < 0.001)] <- "***"

# 设置颜色范围断点
breaks <- seq(-1, 1, length.out = 100)

# 生成热图
b <- pheatmap(data,
              cluster_rows = F,
              cluster_cols = T,
              display_numbers = label,
              cellwidth = 15,
              cellheight = 15,
              fontsize_number = 7,
              fontsize = 10,
              breaks = breaks,
              legend_breaks = c(-1, -0.5, 0, 0.5, 1),
              legend_labels = c("-1", "-0.5", "0", "0.5", "1"))

# 保存图片
jpeg(file = "18CAG.jpeg", height = 900, width = 1600, res = 300)

# 绘制热图
print(b)

# 添加 "R value" 标题（无粗体，位置更靠近颜色条）
grid.text("R value", x = unit(0.92, "npc"), y = unit(0.80, "npc"), 
          gp = gpar(fontsize = 10))  # y值从0.85改为0.78，更靠近颜色条

dev.off()