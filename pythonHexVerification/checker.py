import sys
dh = open('digits_hex.txt', 'r')
wh = open('weights_hex.txt', 'r')
bh = open('b1_hex.txt', 'r')
dList = []
wList = []
bList = []
lines = dh.readlines()
lines2 = wh.readlines()
lines3 = bh.readlines()
i = 0
for line in lines:
    dList.append(hex(int(line,16))[2:].zfill(32))
    #print(dList[i])
    i = i + 1
i = 0
for line in lines2:
    wList.append(hex(int(line,16))[2:].zfill(32))
    #print(wList[i])
    i = i + 1
i = 0
for line in lines3:
    bList.append(hex(int(line,16))[2:].zfill(2))
    #print(bList[i])
    i = i + 1
m1 = []
for i in range(0,40):
    m1.append('')
    for j in range(0,16):
        m1[i] += (hex(int(dList[i][j*2:(j*2) + 2],16) * int(wList[i][j*2:(j*2) + 2],16))[2:].zfill(4))
        continue
addone = []
for j in range(0,40):
    addone.append('')
    for i in range(0,16, 2):
        addone[j] += ( hex( int( m1[j][4 * i:4*i + 4] , 16 ) + int( m1[j][4 * i + 4:4*i + 8] , 16 ) )[2:].zfill(5) )
addtwo = []
for j in range(0,40):
    addtwo.append('')
    for i in range(0,8,2):
        addtwo[j] += hex( int( addone[j][5 * i:5 * i + 5] ,16) + int( addone[j][5 * i + 5:5 * i + 10] ,16) )[2:].zfill(5)
addthree = []
for j in range(0,40):
    addthree.append('')
    for i in range(0,4,2):
        addthree[j] += hex( int( addtwo[j][5 * i:5 * i + 5] ,16) + int( addtwo[j][5 * i + 5:5 * i + 10] ,16) )[2:].zfill(5)
addfour = []
rh = open('results.txt', 'w')
print("MAC Results\n--------------")
for j in range(0,40):
    addfour.append('')
    for i in range(0,2,2):
        addfour[j] += hex( int( addthree[j][5 * i:5 * i + 5] ,16) + int( addthree[j][5 * i + 5:5 * i + 10] ,16) )[2:].zfill(5)
        print(str(j) + " -> ", end='')
        print(addfour[j])
        rh.writelines(addfour[j] + '\n')
bres = open('bresults.txt', 'w')
accadd = []
print("MAC_ACC Results\n------------------")
for j in range(0,10):
    accadd.append('')
    accadd[j] = hex( int( addfour[j*4] ,16) + int( addfour[j*4+1] ,16) + int( addfour[j*4+2] ,16) + int( addfour[j*4+3] ,16) + int(bList[j],16))[2:].zfill(6)
    print(str(j) + " -> ", end='')
    print(accadd[j])
    bres.writelines(accadd[j] + '\n')
bres.close()
rh.close()
dh.close()
wh.close()
