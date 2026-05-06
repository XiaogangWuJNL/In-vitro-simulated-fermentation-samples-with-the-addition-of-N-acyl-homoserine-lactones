setwd("D:/R/file/AHL_12samples/CAG_COG_correlation")
library(psych)
library(reshape2)
library(ggplot2)
#读取数据
env <- read.csv("env.csv", header = TRUE, row.names = 1)  
spe <- read.csv("spe.csv", header = TRUE, row.names = 1)   

#计算相关性矩阵、p值矩阵
spearman <- corr.test(env, spe, method = 'spearman', adjust = 'none')
r <- data.frame(spearman$r)  #spearman 相关系数矩阵
p <- data.frame(spearman$p)  #p 值矩阵
#结果整理以便于作图
r$env <- rownames(r)
p$env <- rownames(p)
r <- melt(r, id = 'env')
p <- melt(p, id = 'env')
spearman <- cbind(r, p$value)
colnames(spearman) <- c('env', 'spe', 'spearman_correlation', 'p.value')
spearman$spe <- factor(spearman$spe, levels = colnames(spe))
head(spearman)  #整理好的环境变量和物种丰度的 spearman 相关性统计表

# 使用排序后的数据绘制热图
p1 <- ggplot() +
  geom_tile(data = spearman, aes(x = env, y = spe, fill = spearman_correlation)) +
  scale_fill_gradientn(colors = c('#00B554', 'white', '#B586CA'), limit = c(-1, 1)) 

p1

#如果想把 spearman 相关系数的显著性也标记在图中，参考如下操作
spearman[which(spearman$p.value<0.001),'sig'] <- '***'
spearman[which(spearman$p.value<0.01 & spearman$p.value>0.001),'sig'] <- '**'
spearman[which(spearman$p.value<0.05 & spearman$p.value>0.01),'sig'] <- '*'
head(spearman)  #整理好的环境变量和物种丰度的 spearman 相关性统计表

#添加
p2 <- p1 +
  geom_text(data = spearman, aes(x = env, y = spe, label = sig), size = 4)

p2


# 创建环状热图
p3 <- ggplot(spearman, aes(x = env, y = spe, fill = spearman_correlation)) +
  geom_tile() +
  scale_fill_gradientn(colors = c('#00B554', 'white', '#B586CA'), limit = c(-1, 1)) +
  coord_polar() +
  theme_bw() +
  theme(panel.border = element_blank(),
        panel.grid = element_blank(),
        axis.title = element_blank(),
        # 增大这个值可以让单元格变宽
        axis.text.x = element_text(size = 9),  
        axis.text.y = element_text(size = 9)) +
  geom_text(aes(label = sig, angle = 0, y = 1.1), size = 4,
            position = position_stack(vjust = 0.5)) +
  # 减小 expand 的 mult 值，让单元格占据更多空间
  scale_y_discrete(expand = expansion(mult = c(0.1, 0))) +  # 原来是 c(1, 0)
  scale_x_discrete(expand = expansion(mult = c(0.25, 0)))      # 原来是 c(0.4, 0)

p3

#保存到PDF
pdf(file = "CAG_COG.pdf", width = 10, height = 10)
print(p3)
dev.off()