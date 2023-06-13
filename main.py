from urllib.request import urlopen, Request
from urllib.parse import quote as urlencode
from bs4 import BeautifulSoup
import sys

# iBp4i -> short answers
# AVsepf -> details
#scl -> showing search for

google_search_url = "https://google.com/search?q="
hdr = { 'User-Agent' : 'Mozilla/5.0 (Windows NT 6.1; Win64; x64)' }

colors = ["\x1b[0m", "\x1b[4m", "\x1b[2m"]
class_names = ["AVsepf", "Ap5OSd"]

def search(query):
    soup = BeautifulSoup(fetch_html(query), "html.parser")

    show_search(soup)
    if (find_class(soup, "iBp4i")): return
    if (show_descripton(soup)): return
    for name in class_names:
        if (find_class(soup, name)): return
    show_website_brefs(soup, 2)

def show_descripton(soup):
    # heading
    heading = soup.select(".zBAuLc .deIvCb");
    if (heading and len(heading) == 1):
        print_ele(heading[0], 1)
 
    # description
    found = False
    for div in soup.select(".Gx5Zad:not(.fP1Qef,.Pg70bf)"):
        for match in div.select("div.s3v9rd div.s3v9rd"):
            found = True
            print_ele(match)
    return found

def find_class(soup, class_name):
    found = False
    for match in soup.find_all("div", class_=class_name):
        print_ele(match)
        if (class_name == "iBp4i"): return True
        found = True
    return found

def show_search(soup):
    search = soup.find(id="scl")
    if (not search): return
    print_ele(search, 2, "showing results for ")
    print("")

def show_website_brefs(soup, count): 
    for ele in soup.find_all("div", class_="fP1Qef"):
        printed = False
        print_ele(ele.find("div", "sCuL3"), 2, "from: ")

        content = ele.find_all("div", class_="v9i61e")
        if (content):
            rating = ele.find("span", class_="oqSTJd")
            if (rating):
                printed = print_ele(rating)
                if (len(content) > 1): print_ele(content[1])
            else: printed = print_ele(content[0])
        else: 
            printed = print_ele(ele.find("div", class_="BNeawe"))

        if (printed): count -= 1
        if (count): print("")
        else: return

def fetch_html(query):
    html_data = ""
    url = google_search_url + urlencode(query)
    request = Request(url, headers=hdr)
    try:
        with urlopen(request) as response:
            html_data = response.read().decode("utf8")
            with open("test.html", "w") as file:
                file.write(html_data)
        return html_data
    except Exception as err:
        print("Error while fetching google.com")
        print(err)
        exit(1)

def format_color(text, code):
    if (code == 0): return text
    return colors[code] + text + colors[0]

def print_ele(ele, code=0, prefix=False):
    if (not ele): return False
    if (prefix): print(format_color(prefix, code), end="")
    print(format_color(ele.text, code))
    return True

def init():
    if (len(sys.argv) == 1):
        print("What do you need to know?")
    for query in sys.argv[1:]:
        search(query)
init()
