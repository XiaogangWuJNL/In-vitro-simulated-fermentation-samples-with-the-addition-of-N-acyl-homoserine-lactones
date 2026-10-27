# ============================================================
# SCFA 热图：ComplexHeatmap 版本，与 CAG 热图风格统一
# ============================================================

setwd("D:/R/file/AHL_12samples/CAG_SCFAs_heatmap_complex")

# ---------- 安装并加载必要的包 ----------
if (!requireNamespace("BiocManager", quietly = TRUE)) {
  install.packages("BiocManager")
}
if (!requireNamespace("ComplexHeatmap", quietly = TRUE)) {
  BiocManager::install("ComplexHeatmap")
}
if (!requireNamespace("circlize", quietly = TRUE)) {
  install.packages("circlize")
}
if (!requireNamespace("Cairo", quietly = TRUE)) {
  install.packages("Cairo")
}

library(ComplexHeatmap)
library(circlize)
library(Cairo)
library(grid)

# ---------- 读取数据 ----------
data <- read.table("R.txt", header = TRUE, row.names = 1, sep = "\t", check.names = FALSE)
pval <- read.table("P.txt", header = TRUE, row.names = 1, sep = "\t", check.names = FALSE)

# ---------- 显著性标记矩阵 ----------
label_matrix <- matrix("", nrow = nrow(pval), ncol = ncol(pval))
label_matrix[which(pval < 0.05)]  <- "*"
label_matrix[which(pval < 0.01)]  <- "**"
label_matrix[which(pval < 0.001)] <- "***"

# ---------- 颜色映射 ----------
col_fun <- colorRamp2(c(-1, 0, 1), c("#00B554", "white", "#B586CA"))

# ---------- 绘制热图 ----------
ht <- Heatmap(
  as.matrix(data),
  name             = "R value",
  cluster_rows     = TRUE,
  cluster_columns  = FALSE,
  row_labels       = rownames(data),
  column_labels    = colnames(data),
  col              = col_fun,
  cell_fun         = function(j, i, x, y, width, height, fill) {
    grid.text(label_matrix[i, j], x, y,
              gp = gpar(fontsize = 12, fontface = "bold"))
  },
  row_names_side   = "right",
  column_names_rot = 90,
  heatmap_legend_param = list(
    at     = c(-1, -0.5, 0, 0.5, 1),
    labels = c("-1", "-0.5", "0", "0.5", "1"),
    title  = "R value"
  )
)

# ---------- 保存图片 ----------
# 画布适当放大，给行名、列名、图例和聚类树留出空间
CairoJPEG(file = "SCFA_CAG_heatmap.jpeg", height = 2600, width = 1500, res = 300)

# padding 顺序：下、左、上、右（mm），右侧留出空间给行名和图例
draw(ht, padding = unit(c(1, 1, 1, 1), "mm"))
dev.off()

cat("热图已保存为 SCFA_CAG_heatmap.jpeg\n")