# hardcoded data input for initial state
# m[i][j][d] is the value at distance i, radius j, depth d
# empty spaces are represented as 0
# no represetnation of the 5th ring since it's orientation can be simulated by rotating the other rings
m=[[[0,0,0,0,11],[6,6,7,8,14],[0,0,8,0,11],[10,11,9,16,11],[0,11,13,2,14],[7,6,9,7,11],[0,11,7,0,14],[15,0,13,9,11],[0,6,21,0,14],[8,17,17,7,14],[0,7,4,14,11],[3,3,5,11,14]],
[[0,7,1,12,14],[0,15,12,3,15],[0,0,0,8,4],[0,0,21,9,5],[0,14,6,0,6],[0,0,15,9,7],[0,9,4,20,8],[0,0,9,12,9],[0,12,18,3,10],[0,0,11,6,11],[0,4,26,0,12],[0,0,14,14,13]],
[[0,0,0,0,9],[0,0,9,17,9],[0,0,0,19,4],[0,0,5,3,4],[0,0,0,12,6],[0,0,10,3,6],[0,0,0,26,3],[0,0,8,6,3],[0,0,0,0,14],[0,0,22,2,14],[0,0,0,13,21],[0,0,16,9,21]],
[[0,0,0,0,7],[0,0,0,10,8],[0,0,0,0,8],[0,0,0,10,3],[0,0,0,0,4],[0,0,0,1,12],[0,0,0,0,2],[0,0,0,9,5],[0,0,0,0,10],[0,0,0,12,7],[0,0,0,0,16],[0,0,0,6,8]]]

def check(): # checks the sum of all radii is 42
    for j in range(len(m[0])):
        n=0
        for i in range(len(m)):
            for x in m[i][j]: # gets first nonzero element
                if x: break
            n+=x
        if (n!=42):
            return False
    return True

def rotate(ring): # rotates ring clockwise
    for i in range(ring+1): # uses that ring n only has values with i <= n
        last=m[i][-1][ring]
        for j in range(len(m[ring])):
            temp=m[i][j][ring]
            m[i][j][ring]=last
            last=temp


n=0
moves=[0,0,0,0]
while not check(): # brute-force
    n+=1
    for r in range(len(m)):
        if n%(len(m[0])**r)==0:
            rotate(r)
            moves[r]+=1

print("Rotate ring i clockwise x_i times:")
print([x%12 for x in moves])