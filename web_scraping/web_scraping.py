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
all_tables = soup.findAll('table', {"class": "wikitable sortable"})
print(all_tables)


# Find all table headers in the Last table
all_tables[0].findAll('th')

# grabbing text from Beautiful Soup
for item in all_tables[0].findAll('th'):
    print(item.text, item.next_sibling)

# saving all table header in a list
header = [item.text.rstrip() for item in all_tables[15].findAll('th')]
print(header)

# Instead of grabbing all individual cells, grab all rows
all_tables[0].findAll('tr')


# Rice dishes (individual)
a1 = []
a2 = []
a3 = []
a4 = []
a5 = []
a6 = []

# all_tables[0] - loop through to create six columns
for row in all_tables[0].findAll('tr'):
    cells = row.findAll('td')
    if len(cells) == 6:
        a1.append(cells[0].find(text=True))
        a2.append(cells[1].find(text=True))
        a3.append(cells[2].find(text=True))
        a4.append(cells[3].find(text=True))
        a5.append(cells[4].find(text=True))
        a6.append(cells[5].find(text=True).rstrip())  # ignore italics

# create dictionary
a_d = dict([(x, 0) for x in header])

# append dictionary with corresponding data list
a_d['Thai name'] = a1
a_d['Thai script'] = a2
a_d['English name'] = a3
a_d['Image'] = a4
a_d['Region'] = a5
a_d['Description'] = a6

# turn dict into dataframe
a_d_df_table = pd.DataFrame(a_d)

# print top 5 records of first table
a_d_df_table.head(5)

#

# Noodle dishes (individual)
b1 = []
b2 = []
b3 = []
b4 = []
b5 = []
b6 = []

# all_tables[1] - loop through to create six columns
for row in all_tables[1].findAll('tr'):
    cells = row.findAll('td')
    if len(cells) == 6:
        b1.append(cells[0].find(text=True))
        b2.append(cells[1].find(text=True))
        b3.append(cells[2].find(text=True))
        b4.append(cells[3].find(text=True))
        b5.append(cells[4].find(text=True))
        b6.append(cells[5].find(text=True).rstrip())  # ignore italics

# create dictionary
b_d = dict([(x, 0) for x in header])

# append dictionary with corresponding data list
b_d['Thai name'] = b1
b_d['Thai script'] = b2
b_d['English name'] = b3
b_d['Image'] = b4
b_d['Region'] = b5
b_d['Description'] = b6

# turn dict into dataframe
b_d_df_table = pd.DataFrame(b_d)

# print top 5 records of first table
b_d_df_table.head(5)

#

# Miscellaneous (individual)
c1 = []
c2 = []
c3 = []
c4 = []
c5 = []
c6 = []

# all_tables[1] - loop through to create six columns
for row in all_tables[2].findAll('tr'):
    cells = row.findAll('td')
    if len(cells) == 6:
        c1.append(cells[0].find(text=True))
        c2.append(cells[1].find(text=True))
        c3.append(cells[2].find(text=True))
        c4.append(cells[3].find(text=True))
        c5.append(cells[4].find(text=True))
        c6.append(cells[5].find(text=True).rstrip())  # ignore italics

# create dictionary
c_d = dict([(x, 0) for x in header])

# append dictionary with corresponding data list
c_d['Thai name'] = c1
c_d['Thai script'] = c2
c_d['English name'] = c3
c_d['Image'] = c4
c_d['Region'] = c5
c_d['Description'] = c6

# turn dict into dataframe
c_d_df_table = pd.DataFrame(c_d)

# print top 5 records of first table
c_d_df_table.head(5)

#

# Curries (Shared Dishes)
d1 = []
d2 = []
d3 = []
d4 = []
d5 = []
d6 = []

# all_tables[1] - loop through to create six columns
for row in all_tables[3].findAll('tr'):
    cells = row.findAll('td')
    if len(cells) == 6:
        d1.append(cells[0].find(text=True))
        d2.append(cells[1].find(text=True))
        d3.append(cells[2].find(text=True))
        d4.append(cells[3].find(text=True))
        d5.append(cells[4].find(text=True))
        d6.append(cells[5].find(text=True).rstrip())  # ignore italics

# create dictionary
d_d = dict([(x, 0) for x in header])

# append dictionary with corresponding data list
d_d['Thai name'] = d1
d_d['Thai script'] = d2
d_d['English name'] = d3
d_d['Image'] = d4
d_d['Region'] = d5
d_d['Description'] = d6

# turn dict into dataframe
d_d_df_table = pd.DataFrame(d_d)

# print top 5 records of first table
d_d_df_table.head(5)

#

# Soups (Shared Dishes)
e1 = []
e2 = []
e3 = []
e4 = []
e5 = []
e6 = []

# all_tables[1] - loop through to create six columns
for row in all_tables[4].findAll('tr'):
    cells = row.findAll('td')
    if len(cells) == 6:
        e1.append(cells[0].find(text=True))
        e2.append(cells[1].find(text=True))
        e3.append(cells[2].find(text=True))
        e4.append(cells[3].find(text=True))
        e5.append(cells[4].find(text=True))
        e6.append(cells[5].find(text=True).rstrip())  # ignore italics

# create dictionary
e_d = dict([(x, 0) for x in header])

# append dictionary with corresponding data list
e_d['Thai name'] = e1
e_d['Thai script'] = e2
e_d['English name'] = e3
e_d['Image'] = e4
e_d['Region'] = e5
e_d['Description'] = e6

# turn dict into dataframe
e_d_df_table = pd.DataFrame(e_d)

# print top 5 records of first table
e_d_df_table.head(5)

#

# Salad (Shared Dishes)
f1 = []
f2 = []
f3 = []
f4 = []
f5 = []
f6 = []

# all_tables[1] - loop through to create six columns
for row in all_tables[5].findAll('tr'):
    cells = row.findAll('td')
    if len(cells) == 6:
        f1.append(cells[0].find(text=True))
        f2.append(cells[1].find(text=True))
        f3.append(cells[2].find(text=True))
        f4.append(cells[3].find(text=True))
        f5.append(cells[4].find(text=True))
        f6.append(cells[5].find(text=True).rstrip())  # ignore italics

# create dictionary
f_d = dict([(x, 0) for x in header])

# append dictionary with corresponding data list
f_d['Thai name'] = f1
f_d['Thai script'] = f2
f_d['English name'] = f3
f_d['Image'] = f4
f_d['Region'] = f5
f_d['Description'] = f6

# turn dict into dataframe
f_d_df_table = pd.DataFrame(f_d)

# print top 5 records of first table
f_d_df_table.head(5)

#

# Fried and Stir-Fried Dishes (Shared Dishes)
g1 = []
g2 = []
g3 = []
g4 = []
g5 = []
g6 = []

# all_tables[1] - loop through to create six columns
for row in all_tables[6].findAll('tr'):
    cells = row.findAll('td')
    if len(cells) == 6:
        g1.append(cells[0].find(text=True))
        g2.append(cells[1].find(text=True))
        g3.append(cells[2].find(text=True))
        g4.append(cells[3].find(text=True))
        g5.append(cells[4].find(text=True))
        g6.append(cells[5].find(text=True).rstrip())  # ignore italics

# create dictionary
g_d = dict([(x, 0) for x in header])

# append dictionary with corresponding data list
g_d['Thai name'] = g1
g_d['Thai script'] = g2
g_d['English name'] = g3
g_d['Image'] = g4
g_d['Region'] = g5
g_d['Description'] = g6

# turn dict into dataframe
g_d_df_table = pd.DataFrame(g_d)

# print top 5 records of first table
g_d_df_table.head(5)

#

# Deep-Fried Dishes (Shared Dishes)
h1 = []
h2 = []
h3 = []
h4 = []
h5 = []
h6 = []

# all_tables[1] - loop through to create six columns
for row in all_tables[7].findAll('tr'):
    cells = row.findAll('td')
    if len(cells) == 6:
        h1.append(cells[0].find(text=True))
        h2.append(cells[1].find(text=True))
        h3.append(cells[2].find(text=True))
        h4.append(cells[3].find(text=True))
        h5.append(cells[4].find(text=True))
        h6.append(cells[5].find(text=True).rstrip())  # ignore italics

# create dictionary
h_d = dict([(x, 0) for x in header])

# append dictionary with corresponding data list
h_d['Thai name'] = h1
h_d['Thai script'] = h2
h_d['English name'] = h3
h_d['Image'] = h4
h_d['Region'] = h5
h_d['Description'] = h6

# turn dict into dataframe
h_d_df_table = pd.DataFrame(h_d)

# print top 5 records of first table
h_d_df_table.head(5)

#

# Grilled Dishes (Shared Dishes)
i1 = []
i2 = []
i3 = []
i4 = []
i5 = []
i6 = []

# all_tables[1] - loop through to create six columns
for row in all_tables[8].findAll('tr'):
    cells = row.findAll('td')
    if len(cells) == 6:
        i1.append(cells[0].find(text=True))
        i2.append(cells[1].find(text=True))
        i3.append(cells[2].find(text=True))
        i4.append(cells[3].find(text=True))
        i5.append(cells[4].find(text=True))
        i6.append(cells[5].find(text=True).rstrip())  # ignore italics

# create dictionary
i_d = dict([(x, 0) for x in header])

# append dictionary with corresponding data list
i_d['Thai name'] = i1
i_d['Thai script'] = i2
i_d['English name'] = i3
i_d['Image'] = i4
i_d['Region'] = i5
i_d['Description'] = i6

# turn dict into dataframe
i_d_df_table = pd.DataFrame(i_d)

# print top 5 records of first table
i_d_df_table.head(5)

#

# Steamed or Blanched Dishes (Shared Dishes)
j1 = []
j2 = []
j3 = []
j4 = []
j5 = []
j6 = []

# all_tables[1] - loop through to create six columns
for row in all_tables[9].findAll('tr'):
    cells = row.findAll('td')
    if len(cells) == 6:
        j1.append(cells[0].find(text=True))
        j2.append(cells[1].find(text=True))
        j3.append(cells[2].find(text=True))
        j4.append(cells[3].find(text=True))
        j5.append(cells[4].find(text=True))
        j6.append(cells[5].find(text=True).rstrip())  # ignore italics

# create dictionary
j_d = dict([(x, 0) for x in header])

# append dictionary with corresponding data list
j_d['Thai name'] = j1
j_d['Thai script'] = j2
j_d['English name'] = j3
j_d['Image'] = j4
j_d['Region'] = j5
j_d['Description'] = j6

# turn dict into dataframe
j_d_df_table = pd.DataFrame(j_d)

# print top 5 records of first table
j_d_df_table.head(5)

#

# Stewed (Shared Dishes)
k1 = []
k2 = []
k3 = []
k4 = []
k5 = []
k6 = []

# all_tables[1] - loop through to create six columns
for row in all_tables[10].findAll('tr'):
    cells = row.findAll('td')
    if len(cells) == 6:
        k1.append(cells[0].find(text=True))
        k2.append(cells[1].find(text=True))
        k3.append(cells[2].find(text=True))
        k4.append(cells[3].find(text=True))
        k5.append(cells[4].find(text=True))
        k6.append(cells[5].find(text=True).rstrip())  # ignore italics

# create dictionary
k_d = dict([(x, 0) for x in header])

# append dictionary with corresponding data list
k_d['Thai name'] = k1
k_d['Thai script'] = k2
k_d['English name'] = k3
k_d['Image'] = k4
k_d['Region'] = k5
k_d['Description'] = k6

# turn dict into dataframe
k_d_df_table = pd.DataFrame(k_d)

# print top 5 records of first table
k_d_df_table.head(5)

#

# Dipping Sauces and Pastes (Shared Dishes)
l1 = []
l2 = []
l3 = []
l4 = []
l5 = []
l6 = []

# all_tables[1] - loop through to create six columns
for row in all_tables[11].findAll('tr'):
    cells = row.findAll('td')
    if len(cells) == 6:
        l1.append(cells[0].find(text=True))
        l2.append(cells[1].find(text=True))
        l3.append(cells[2].find(text=True))
        l4.append(cells[3].find(text=True))
        l5.append(cells[4].find(text=True))
        l6.append(cells[5].find(text=True).rstrip())  # ignore italics

# create dictionary
l_d = dict([(x, 0) for x in header])

# append dictionary with corresponding data list
l_d['Thai name'] = l1
l_d['Thai script'] = l2
l_d['English name'] = l3
l_d['Image'] = l4
l_d['Region'] = l5
l_d['Description'] = l6

# turn dict into dataframe
l_d_df_table = pd.DataFrame(l_d)

# print top 5 records of first table
l_d_df_table.head(5)

#

# Miscellaneous (Shared Dishes)
m1 = []
m2 = []
m3 = []
m4 = []
m5 = []
m6 = []

# all_tables[1] - loop through to create six columns
for row in all_tables[12].findAll('tr'):
    cells = row.findAll('td')
    if len(cells) == 6:
        m1.append(cells[0].find(text=True))
        m2.append(cells[1].find(text=True))
        m3.append(cells[2].find(text=True))
        m4.append(cells[3].find(text=True))
        m5.append(cells[4].find(text=True))
        m6.append(cells[5].find(text=True).rstrip())  # ignore italics

# create dictionary
m_d = dict([(x, 0) for x in header])

# append dictionary with corresponding data list
m_d['Thai name'] = m1
m_d['Thai script'] = m2
m_d['English name'] = m3
m_d['Image'] = m4
m_d['Region'] = m5
m_d['Description'] = m6

# turn dict into dataframe
m_d_df_table = pd.DataFrame(m_d)

# print top 5 records of first table
m_d_df_table.head(5)

#

# Savoury snacks and startern
n1 = []
n2 = []
n3 = []
n4 = []
n5 = []
n6 = []

# all_tables[1] - loop through to create six columns
for row in all_tables[13].findAll('tr'):
    cells = row.findAll('td')
    if len(cells) == 6:
        n1.append(cells[0].find(text=True))
        n2.append(cells[1].find(text=True))
        n3.append(cells[2].find(text=True))
        n4.append(cells[3].find(text=True))
        n5.append(cells[4].find(text=True))
        n6.append(cells[5].find(text=True).rstrip())  # ignore italics

# create dictionary
n_d = dict([(x, 0) for x in header])

# append dictionary with corresponding data list
n_d['Thai name'] = n1
n_d['Thai script'] = n2
n_d['English name'] = n3
n_d['Image'] = n4
n_d['Region'] = n5
n_d['Description'] = n6

# turn dict into dataframe
n_d_df_table = pd.DataFrame(n_d)

# print top 5 records of first table
n_d_df_table.head(5)

#

# Sweet snacks and desserts
o1 = []
o2 = []
o3 = []
o4 = []
o5 = []
o6 = []

# all_tables[1] - loop through to create six columns
for row in all_tables[14].findAll('tr'):
    cells = row.findAll('td')
    if len(cells) == 6:
        o1.append(cells[0].find(text=True))
        o2.append(cells[1].find(text=True))
        o3.append(cells[2].find(text=True))
        o4.append(cells[3].find(text=True))
        o5.append(cells[4].find(text=True))
        o6.append(cells[5].find(text=True).rstrip())  # ignore italics

# create dictionary
o_d = dict([(x, 0) for x in header])

# append dictionary with corresponding data list
o_d['Thai name'] = o1
o_d['Thai script'] = o2
o_d['English name'] = o3
o_d['Image'] = o4
o_d['Region'] = o5
o_d['Description'] = o6

# turn dict into dataframe
o_d_df_table = pd.DataFrame(o_d)

# print top 5 records of first table
o_d_df_table.head(5)

#

# Drinks
p1 = []
p2 = []
p3 = []
p4 = []
p5 = []
p6 = []

# all_tables[1] - loop through to create six columns
for row in all_tables[15].findAll('tr'):
    cells = row.findAll('td')
    if len(cells) == 6:
        p1.append(cells[0].find(text=True))
        p2.append(cells[1].find(text=True))
        p3.append(cells[2].find(text=True))
        p4.append(cells[3].find(text=True))
        p5.append(cells[4].find(text=True))
        p6.append(cells[5].find(text=True).rstrip())  # ignore italics

# create dictionary
p_d = dict([(x, 0) for x in header])

# append dictionary with corresponding data list
p_d['Thai name'] = p1
p_d['Thai script'] = p2
p_d['English name'] = p3
p_d['Image'] = p4
p_d['Region'] = p5
p_d['Description'] = p6

# turn dict into dataframe
p_d_df_table = pd.DataFrame(p_d)

# print top 5 records of first table
p_d_df_table.head(5)


# join data frame with same columns in pandas
# use ignore_index=True parameter as alternative
thai_dishes = pd.concat([a_d_df_table,
                         b_d_df_table,
                         c_d_df_table,
                         d_d_df_table,
                         e_d_df_table,
                         f_d_df_table,
                         g_d_df_table,
                         h_d_df_table,
                         i_d_df_table,
                         j_d_df_table,
                         k_d_df_table,
                         l_d_df_table,
                         m_d_df_table,
                         n_d_df_table,
                         o_d_df_table,
                         p_d_df_table])

# Explore data frame with pandas
thai_dishes.columns
thai_dishes.dtypes
thai_dishes.head(3)
thai_dishes.tail(3)
# count frequency of variables in a column
thai_dishes['Thai name'].value_counts()
# count missing values in a column
pd.isnull(thai_dishes['Thai name'].value_counts())


# Write data frame to csv
# thai_dishes.to_csv("thai_dishes.csv")
