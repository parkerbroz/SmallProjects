import requests
import urllib.request

# title headers for UI
youtwobeArt="""
                   _                 _
                  | |               | |
 _   _  ___  _   _| |___      _____ | |__   ___
| | | |/ _ \| | | | __\ \ /\ / / _ \| '_ \ / _ \\
| |_| | (_) | |_| | |_ \ V  V / (_) | |_) |  __/
 \__, |\___/ \__,_|\__| \_/\_/ \___/|_.__/ \___|
  __/ |
 |___/
\n"""
goodbyeArt="""
 _
| |
| |__  _   _  ___
| '_ \| | | |/ _ \\
| |_) | |_| |  __/
|_.__/ \__, |\___|
        __/ |
       |___/
\n"""

# user interaction handler
class UI:
    def __init__(self):
        self.userinput=""
        self.query=""
        self.state=0
        self.vids=[]
        self.body="1) search for a vid\n"
        self.body+="2) enter vid id\n"
        self.body+="\nyour choice: "
        self.header=youtwobeArt

    def run(self):
        clearConsole()
        print(self.header)
        if self.state==-1:
            exit()
        self.userinput=input(self.body)
        self.update()

    def update(self):
        if (self.state==0):
            if (self.userinput=="1"):
                self.body="pop a title in here: "
                self.state=1
            elif (self.userinput=="2"):
                self.body="pop an id in here: "
                self.state=4
        elif (self.state==1):
            self.body="results for: "+self.userinput+"\n\n"
            # shenanigans with for loops and query stuff
            self.vids=getVids(self.userinput)
            for i in range(0,len(self.vids)):
                self.body+=str(i)+". "+str(self.vids[i])+"\n"
            self.body+="\n"
            self.body+="1) watch one of them\n"
            self.body+="2) start over\n"
            self.body+="\nyour choice: "
            self.state=2
        elif (self.state==2):
            if (self.userinput=="1"):
                self.body="which to watch?\n\n"
                # add options
                for i in range(0,len(self.vids)):
                   self.body+=str(i)+". "+repr(self.vids[i])+"\n"
                self.body+="\n"
                self.body+="\nyour choice: "
                self.state=3
            elif (self.userinput=="2"):
                self.body="1) search for a vid\n"
                self.body+="2) enter vid id\n"
                self.body+="\nyour choice: "
                self.state=0
        elif (self.state==3):
            if (self.userinput.isdigit() and int(self.userinput)>=0 and int(self.userinput)<len(self.vids)):
                #urllib.request.urlretrieve(self.vids[int(self.inn)].vidUrl, self.vids[int(self.inn)].title+".mp4")
                self.body="sourcing: \""+self.vids[int(self.userinput)].title+"\" for your viewing pleasure\n\n"
                self.body+=self.vids[int(self.userinput)].getVidUrl()+"\n\n"
                self.body+="1) start over\n"
                self.body+="2) quit\n"
                self.body+="\nyour choice: "
                self.state=5
        elif (self.state==4):
            #urllib.request.urlretrieve(getVidUrl(self.inn), self.inn+".mp4")
            self.body="here it is:\n\n"
            self.body+=getVidUrl(self.userinput)+"\n\n"
            self.body+="1) start over\n"
            self.body+="2) quit\n"
            self.body+="\nyour choice: "
            self.state=5
        elif (self.state==5):
            if (self.userinput=="1"):
                self.body="1) search for a vid\n"
                self.body+="2) enter vid id\n"
                self.body+="\nyour choice: "
                self.state=0
            elif (self.userinput=="2"):
                self.body="come back soon!"
                self.header=goodbyeArt
                self.state=-1
        self.run()


# kinda self explanatory
class Video:
    def __init__(self, title, context, vidID):
        self.title=title
        self.context=context
        self.vidID=vidID

    def __repr__(self):
        return self.title+self.context+" ("+self.vidID+")"
    
    def getVidUrl(self):
        return getVidUrl(self.vidID)


# functions that are just generally useful

# decodes url into usable format
def decodeUrl(url):
    encodeds=["%3A","%2F","%3F","%3D","%26","%25","%2C","\\\\u0026"]
    decodeds=[":","/","?","=","&","%",",","&"]
    #for _ in range(0,2):
    i=0
    while i<len(encodeds):
        while url.find(encodeds[i])>0:
            url=url[:url.find(encodeds[i])]+decodeds[i]+url[url.find(encodeds[i])+len(encodeds[i]):]
        i+=1
    return url

# prints 50 lines
def clearConsole():
    for i in range(0,50):
        print()

# gets options from query source code
def getVids(query):
    ret=[]
    page=requests.get("https://www.youtube.com/results?search_query="+query)
    source=str(page.content)
    i=source.find("title\":{\"runs\"")
    while i!=-1 and len(ret)<10:
        vidSlice=source[i:i+1500]
        if (vidSlice.find("}}},\"longBylineText")==-1):
            source=source[i+1500:len(source)]
            i=source.find("title\":{\"runs\"")
            continue
        vidInfo=vidSlice[vidSlice.find("accessibilityData\":{\"label\":")+29:vidSlice.find("}}},\"longBylineText")-1]
        title=vidInfo[:vidInfo.rfind("by")-1]
        context=vidInfo[vidInfo.rfind("by")-1:]
        idIndex=vidSlice.find("webCommandMetadata\":{\"url\":\"/watch?v=")
        vidID=vidSlice[idIndex+37:idIndex+48] # all IDs are 11 characters long
        ret.append(Video(title, context, vidID))
        source=source[i+1500:len(source)]
        i=source.find("title\":{\"runs\"")
    return ret

# take html code for ascii out of title
def simplifyTitle(titleSlice):
    while (titleSlice.find("&")!=-1):
        firstHalf=titleSlice[0:titleSlice.find("&")]
        secondHalfish=titleSlice[titleSlice.find("&"):len(titleSlice)]
        titleSlice=firstHalf+secondHalfish[secondHalfish.find(";")+1:len(secondHalfish)]
    while (titleSlice.find("\\x")!=-1):
        titleSlice=titleSlice[0:titleSlice.find("\\x")]+titleSlice[titleSlice.find("\\x")+4:len(titleSlice)]
    return titleSlice

# returns hosted link of video
def getVidUrl(vidID):
    page=requests.get("https://www.youtube.com/watch?v="+vidID)
    source=str(page.content)
    urlOnwardSlice=source[source.find("videoplayback")-42:len(source)]
    encodedUrl=urlOnwardSlice[0:urlOnwardSlice.find("\"")]
    return decodeUrl(encodedUrl)

# this is it
ui=UI()
ui.run()
