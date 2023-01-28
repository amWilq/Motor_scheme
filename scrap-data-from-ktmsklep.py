import requests
from bs4 import BeautifulSoup

url = 'https://ktmsklep.pl/oryginalne-czesci-zamienne/208622/150-exc-tpi/419761/rama#part-title'
response = requests.get(url)
soup = BeautifulSoup(response.text, 'html.parser')

name_list = [name.text for name in soup.find_all('p', class_='t-name')]
number_list = [number.text for number in soup.find_all('p', class_='t-number')]
lp = [number.text for number in soup.find_all('td', class_='t-lp ref')]

parts_list = []

for i in range(len(name_list)):
    part = '{\n\t\t\t\t\t"id": '+lp[i]+',\n\t\t\t\t\t"namePart": '+ '"'+name_list[i]+'"'+',\n\t\t\t\t\t"partNumber": '+'"'+number_list[i]+'"\n\t\t\t\t}'
    parts_list.append(part)

result = '\n\t"parts": [\n\t\t\t'+",\n\t\t\t".join(parts_list)+'\n\t]\n'

print(result)