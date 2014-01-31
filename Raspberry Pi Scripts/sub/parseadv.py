FILENAME = 'rawdata.temp'
data = ''
advData = ''
count = 0

#Open file with the data gathered from gatttool
file = open(FILENAME)

#Get all the lines from the file 
lines = file.readlines()

#Grab the relevant data from the lines
for i in lines:
        data = data + i[24:len(i)-2] + ' '

#Convert the data to ascii and format it into the proper format for the Advertisement data 
dataList = data.split(' ')
for i in dataList[0:len(dataList)-1]:
        if (i != ''):
                advData = advData + chr(int(i,16))
        if ((count - 1) % 2 == 0 and count != 0 and count < len(dataList)-2):
                advData = advData + ' '
        count = count + 1

#Output the final advertisement data
print(advData)