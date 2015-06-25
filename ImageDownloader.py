import os
import sys
import time
import urllib
from urllib import FancyURLopener
import json

# Define search term
searchTerm = sys.argv[1]

# Replace spaces ' ' in search term for '%20' in order to comply with request
searchTerm = searchTerm.replace(' ','%20')


# Start FancyURLopener with defined version
class MyOpener(FancyURLopener):
    version = 'Mozilla/5.0 (Windows; U; Windows NT 5.1; it; rv:1.8.1.11) Gecko/20071127 Firefox/2.0.0.11'
myopener = MyOpener()

# Set count to 0
count= 0

for i in range(1, 40):
    print(count)
    # Notice that the start changes for each iteration in order to request a new set of images for each loop
    url = ('https://ajax.googleapis.com/ajax/services/search/images?' + 'v=1.0&q='+searchTerm+'&start='+str(i*4)+'&userip=MyIP')
    print(url)

    import requests

    results = requests.get(url).json()
    print(results)
    data = results['responseData']
    if not data:
        continue
    dataInfo = data['results']
    if dataInfo:
        # Iterate for each result and get unescaped url
        for myUrl in dataInfo:
            count = count + 1
            print(myUrl['unescapedUrl'])

            myopener.retrieve(myUrl['unescapedUrl'],str(count+400)+'.jpg')

    # Sleep for one second to prevent IP blocking from Google
    time.sleep(1)
