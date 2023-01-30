import requests
from bs4 import BeautifulSoup

url = 'https://ktmsklep.pl/oryginalne-czesci-zamienne/208649/500-exc-f/419659/przod-amortyzatory-polki-zawieszenia#part-title'
response = requests.get(url)
soup = BeautifulSoup(response.text, 'html.parser')

box_scheme = soup.find_all('div', class_='box box-scheme')
id = 1

with open('result.txt', 'w') as f:
    for box in box_scheme:
        title = box.find('h3', class_='title').get_text()
        link = box.find('a')['href']
        image_url = box.find('img')['src']
        link = 'https://ktmsklep.pl/' +link

        response = requests.get(link)
        soup = BeautifulSoup(response.text, 'lxml')
        name_list = [name.text for name in soup.find_all('p', class_='t-name')]
        number_list = [number.text for number in soup.find_all('p', class_='t-number')]
        lp = [number.text for number in soup.find_all('td', class_='t-lp ref')]
        parts_list = []
        parts_image_url = []
        for i in range(len(name_list)):
          name_list[i] = name_list[i].replace("'", '"')
          part = '{\n\t\t\t\t\t"id": '+lp[i]+',\n\t\t\t\t\t"namePart": '+ '"'+name_list[i]+'"'+',\n\t\t\t\t\t"partNumber": '+'"'+number_list[i]+'"\n\t\t\t\t}'
          parts_list.append(part)
          main_image = soup.find('div', class_='main-image')
          parts_image_url = main_image.find('img')['src']


        result = '{\n\t"id": '+str(id)+',\n\t"nameTypePart": '+'"'+title+'"'+',\n\t"imageUrl": '+'"'+image_url+'"'+',\n\t"partsImageUrl": '+'"'+parts_image_url+'"'+',\n\t"parts": [\n\t\t\t'+",\n\t\t\t".join(parts_list)+'\n\t]\n},'
        f.write(result + '\n')
        id += 1