import sys
from PIL import Image

filename = sys.argv[1]
thrd = int(sys.argv[2])
print filename

im = Image.open(filename)
im = im.convert("L")
width = 568
height = 568
im = im.resize((width,height))
out = Image.new(mode='1', size=(width,height))
mat  = im.load()
out_mat = out.load()
total=0
allblack=0
avg_background=0
avg_spores=0

for x in range (155,391):
	for y in range (100,266):
		total=total+1
		if mat[x,y] >= thrd:
			out_mat[x,y] = 1
			avg_spores = avg_spores + mat[x,y]
		else:
			out_mat[x,y] = 0
			allblack = allblack + 1
			avg_background = avg_background + mat[x,y]


print allblack, total
spores_avg = avg_spores / (float(allblack)+1)
backg_avg = avg_background / (float(total)-float(allblack))
frac = float(allblack) / float(total)
name,ext = filename.split(".")
out1 = out.crop((155,100,390,265)).save(str(name) + ' thrd-' + str(thrd) + ' frac-' + str(frac) + ' back-' + str(backg_avg) + ".jpg")
print frac
print avg_background
print avg_spores
print backg_avg
print spores_avg