# 设置工作目录
setwd("D:/R/file/AHL_12samples/CAG_Metabonomics_correlation_spearman_results")

# 加载依赖包
library(psych)
library(reshape2)

# 读取数据
env <- read.csv("env.csv", header = TRUE, row.names = 1)  
spe <- read.csv("spe.csv", header = TRUE, row.names = 1)   

# 计算Spearman相关性与P值（未校正P值，和你原逻辑一致）
spearman_res <- corr.test(env, spe, method = 'spearman', adjust = 'none')

# 1. 提取相关系数矩阵、P值矩阵（宽表，和原始矩阵布局一致）
r_matrix <- data.frame(spearman_res$r)
p_matrix <- data.frame(spearman_res$p)

# 导出宽表（方便按行列对照查看）
write.csv(r_matrix, file = "Spearman_相关系数矩阵.csv", row.names = TRUE, quote = FALSE)
write.csv(p_matrix, file = "Spearman_P值矩阵.csv", row.names = TRUE, quote = FALSE)

# 2. 转换为长格式（一对一配对，便于筛选、统计）
r_matrix$env <- rownames(r_matrix)
p_matrix$env <- rownames(p_matrix)

r_long <- melt(r_matrix, id = "env")
p_long <- melt(p_matrix, id = "env")

# 合并R值、P值
cor_table <- cbind(r_long, p_long$value)
colnames(cor_table) <- c("环境变量", "物种/功能", "Spearman_R", "P_value")

# 3. 添加显著性标记
cor_table$显著性 <- NA
cor_table[cor_table$P_value < 0.001, "显著性"] <- "***"
cor_table[cor_table$P_value >= 0.001 & cor_table$P_value < 0.01, "显著性"] <- "**"
cor_table[cor_table$P_value >= 0.01 & cor_table$P_value < 0.05, "显著性"] <- "*"

# 导出完整长表（含R、P、显著性）
write.csv(cor_table, file = "Spearman_R_P_显著性总表.csv", row.names = FALSE, quote = FALSE)

# 4. 单独筛选并导出 P<0.05 的显著关联结果
sig_table <- subset(cor_table, !is.na(显著性))
write.csv(sig_table, file = "显著相关性结果P小于0.05.csv", row.names = FALSE, quote = FALSE)

# 控制台预览前10行数据
head(cor_table, 10)