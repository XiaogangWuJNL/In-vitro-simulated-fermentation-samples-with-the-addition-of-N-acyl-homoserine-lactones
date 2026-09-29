# ============================================================
# 热图绘制：使用 ComplexHeatmap + plotmath 表达式
# 正确显示分子式的下标与上标，并保留行列名、图例、聚类树
# ============================================================

setwd("D:/R/file/AHL_12samples/CAG_Metabonomics_heatmap_lable")

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

# ---------- 分子式 -> plotmath 表达式 ----------
formula_to_expr <- function(x) {
  # 特例：Fe[59]O4S -> 59 作为 Fe 左上角上标
  if (x == "Fe[59]O4S") {
    return("{}^59*Fe*O[4]*S")
  }
  
  pattern <- "([A-Z][a-z]?)([0-9]*)"
  m <- gregexpr(pattern, x)
  parts <- regmatches(x, m)[[1]]
  
  result <- sapply(parts, function(p) {
    elem <- gsub("[0-9]", "", p)
    num  <- gsub("[^0-9]", "", p)
    if (nchar(num) > 0) {
      paste0(elem, "[", num, "]")
    } else {
      elem
    }
  })
  
  paste(result, collapse = "*")
}

expr_strings <- sapply(rownames(data), formula_to_expr)
row_labels   <- parse(text = expr_strings)

# ---------- 显著性标记矩阵 ----------
label_matrix <- matrix("", nrow = nrow(pval), ncol = ncol(pval))
label_matrix[which(pval < 0.05)]  <- "*"
label_matrix[which(pval < 0.01)]  <- "**"
label_matrix[which(pval < 0.001)] <- "***"

# ---------- 颜色映射 ----------
col_fun <- colorRamp2(c(-1, 0, 1), c("#00B554", "white", "#B586CA"))

# ---------- 绘制热图（不指定固定宽高，让 ComplexHeatmap 自动布局） ----------
ht <- Heatmap(
  as.matrix(data),
  name             = "R value",
  cluster_rows     = FALSE,
  cluster_columns  = TRUE,
  row_labels       = row_labels,
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
CairoJPEG(file = "18CAG_meta.jpeg", height = 2400, width = 2400, res = 300)

# padding 顺序：下、左、上、右（mm），右侧留出空间给行名和图例
draw(ht, padding = unit(c(10, 10, 10, 40), "mm"))

dev.off()

cat("热图已保存为 18CAG_meta.jpeg\n")