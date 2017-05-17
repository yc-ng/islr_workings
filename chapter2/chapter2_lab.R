
# 2.3.2 Graphics ----------------------------------------------------------

x <- rnorm(100)
y <- rnorm(100)
plot(x, y)
plot(x, y, xlab = "this is the x-axis", ylab = "this is the y-axis",
     main = "Plot of X vs Y")

# save to pdf file
pdf("Figure.pdf")
plot(x, y, col = "green")
dev.off()

# define dimensional vectors for contour plot
x <- seq(-pi, pi, length.out = 50)
y <- x
# matrix via outer product of arrays
f <- outer(x, y, function(x, y) cos(y)/(1 + x^2))
# plot contour plot
contour(x, y, f)
contour(x, y, f, nlevels = 45, add = TRUE)

fa <- (f - t(f))/2
contour(x, y, fa, nlevels = 15)

# colour-coded contour plot, i.e. heatmap
image(x, y, fa)

# 3D plot
persp(x, y, fa)
persp(x, y, fa, theta = 30) # azimuthal(horizontal) rotation
persp(x, y, fa, theta = 30, phi = 20) # add colatitude(vertical) rotation
persp(x, y, fa, theta = 30, phi = 70)
persp(x, y, fa, theta = 30, phi = 40)

