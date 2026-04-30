from PIL import Image
import numpy as np
# Load images
img1 = Image.open("res/fox.jpg")
img2 = Image.open("res/fox_secret.jpg")
# Convert to grayscale
img1 = img1.convert("L")
img2 = img2.convert("L")
# Convert to arrays
arr1 = np.array(img1)
arr2 = np.array(img2)
# Flatten
vec1 = arr1.flatten()
vec2 = arr2.flatten()
# Correlation
corr = np.corrcoef(vec1, vec2)[0, 1]

print("Pearson correlation:", corr)
print("Edited on host.")