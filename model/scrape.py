from bs4 import BeautifulSoup
import requests
import re
from  urllib.request import urlopen, Request, urlretrieve
import os
import json

from colorama import init, Fore, Back, Style
init()


def get_soup(url,header):
    return BeautifulSoup(urlopen(Request(url,headers=header)),'html.parser')


query = "castel-sant-angelo"
url="https://www.google.co.in/search?q="+query+"&source=lnms&tbm=isch"
print(Fore.GREEN +  "URL: " + url)
print(Style.RESET_ALL)

DIR= os.path.join(os.getcwd(), "data/2/")
header={'User-Agent':"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.134 Safari/537.36"
}
soup = get_soup(url,header)


ActualImages=[]# contains the link for Large original images, type of  image
for a in soup.find_all("div",{"class":"rg_meta"}):
    link , Type = json.loads(a.text)["ou"]  ,json.loads(a.text)["ity"]
    ActualImages.append((link,Type))

print (Style.DIM + "There are a total of" , len(ActualImages) , "images")
print(Style.RESET_ALL)

if not os.path.exists(DIR):
            os.mkdir(DIR)
DIR = os.path.join(DIR)


for i , (img , Type) in enumerate(ActualImages):
    try:
        raw_img = urlopen(img).read()

        
        dirname = os.path.dirname(DIR + img)
        print("Dirname" + dirname)
        if not os.path.exists(dirname):
          os.makedirs(dirname)

        f = open(os.path.join(DIR , img.split('.')[1] + ".jpg"), 'wb')
        f.write(raw_img)
        f.close()
    except Exception as e:
        print(Fore.RED + "Could not load : " + Style.RESET_ALL)
        print(img)
        print(Fore.RED + str(e) + Style.RESET_ALL)
        print('\n')