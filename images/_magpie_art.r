library(mathart)
library(ggart)
library(ggforce)
library(tidyverse)

# A is amplitude
# f is frequency
# p is phase
# d is damping

# 1: horizontal
# 2: horizontal
# 3: vertical
# 4: vertical
df <- harmonograph(A1 = 0.95, A2 = 0.6, A3 = 0.5, A4 = 1,
                   d1 = 0.005, d2 = 0.001, d3 = 0.001, d4 = 0.0075,
                   f1 = 6, f2 = 2, f3 = 6, f4 = 2,
                   p1 = 0, p2 = pi/2, p3 = 0.5, p4 = pi/3 + 0.5)

p <- ggplot() +
  geom_path(aes(x, y), df[4000:nrow(df),], alpha = 0.25, size = 0.5, color = "#4e2a8e") +
  coord_equal() +
  theme_blankcanvas(margin_cm = 0)

show(p)
ggsave("logo.png", p, width = 20, height = 20, units = "cm")
ggsave("logo_small.png", p, width = 10, height = 10, units = "cm")
