import requests
from bs4 import BeautifulSoup
import urllib.request
import urllib.parse
import urllib.error
import ssl
import pandas as pd


url = "https://en.wikipedia.org/wiki/List_of_Thai_dishes"
s = requests.Session()
response = s.get(url, timeout=10)
response


ctx = ssl.create_default_context()
ctx.check_hostname = False
ctx.verify_mode = ssl.CERT_NONE

html = urllib.request.urlopen(url, context=ctx).read()
soup = BeautifulSoup(html, 'html.parser')
soup.title.string


# Find ALL Tables - there are 16 tables
# len(all_tables) = 16
all_tables = soup.findAll('table', {"class": "wikitable sortable"})
# print(all_tables)

# saving all table header in a list
# rstrip() gets rid of
header = [item.text.rstrip() for item in all_tables[0].findAll('th')]
print(header)


a1 = []
a2 = []
a3 = []
a4 = []
a5 = []
a6 = []

# loop through all 16 tables
a = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]

for i in a:
    for row in all_tables[i].findAll('tr'):
        cells = row.findAll('td')
        if len(cells) == 6:
            # needs flattening
            a1.append([string for string in cells[0].strings])
            a2.append(cells[1].find(text=True))
            a3.append(cells[2].find(text=True))
            a4.append(cells[3].find(text=True))
            a5.append(cells[4].find(text=True))
            # needs flattening
            a6.append([string for string in cells[5].strings])


# create dictionary
table = dict([(x, 0) for x in header])

# append dictionary with corresponding data list
table['Thai name'] = a1
table['Thai script'] = a2
table['English name'] = a3
table['Image'] = a4
table['Region'] = a5
table['Description'] = a6

# turn dict into dataframe
df_table = pd.DataFrame(table)

# print top 5 records of first table
df_table.head(5)

# Need to Flatten Two Columns: 'Thai name' and 'Description'
# Create two new columns
df_table['Thai name 2'] = ""
df_table['Description2'] = ""

# join all words in the list for each of 328 rows and set to thai_dishes['Description2'] column
# automatically flatten the list
df_table['Description2'] = [
    ' '.join(cell) for cell in df_table['Description']]

df_table['Thai name 2'] = [
    ' '.join(cell) for cell in df_table['Thai name']]

print(df_table.columns)
