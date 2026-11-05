import os
import re
import sys
from urllib.parse import unquote, urlparse
from m3u8 import M3U8
from urllib.request import getproxies
import httpx
headers = {
    'user-agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) '
                  'Chrome/99.0.4844.74 Safari/537.36'}
def getporoxy():
    proxy = getproxies()
    if proxy:
        if 'https' in proxy:
            proxy['https'] = proxy['https'].replace('https','http')
        proxy.pop('ftp', None)
        return proxy
    return None
def gethttpxporoxy():
    proxy = getproxies()
    d = {}
    if 'http' in proxy:
        d['http://'] = proxy['http']
    if 'https' in proxy:
        d['https://'] = proxy['https'].replace('https','http',1)
    return d or None
def loadm3u8(url,b=False):
    r = httpx.get(url, verify=False, headers=headers,proxies=gethttpxporoxy())
    if b:
        # baseurl =r.url
        l = url.split("/")
        baseurl = l[0] + "//" + l[2]
    else:
        baseurl = "/".join(url.split("/")[:-1])+"/"
        # l = r.url.split("/")
        # baseurl = l[0] + "//" + l[2]
    # baseurl = urljoin(url, '.')
    return M3U8(r.text, base_uri=baseurl, custom_tags_parser=None)


def checkhentai(url):
    if "uncensoredhentai" in url:
        return True
    # elif "hentai.tv" in url:
    #     return True
    elif "animeidhentai" in url:
        return True


def checkNameValid(name=None):
    """
    Check for invalid file name characters!
    """
    reg = re.compile(r'[\\/:*?"<>|\r\n]+')
    valid_name = reg.findall(name)
    if valid_name:
        for nv in valid_name:
            name = name.replace(nv, "_")
    return name









IS_WIN = os.name == "nt"
FFMPEG = os.environ.get("FFMPEG_BIN", "ffmpeg.exe" if IS_WIN else "ffmpeg")
CHROMEDRIVER = os.environ.get("CHROMEDRIVER_BIN", "chromedriver.exe" if IS_WIN else "chromedriver")


def url_to_path(url):
    """Convert a file:// URL (as produced by QML) to a local filesystem path."""
    if not url.startswith("file:"):
        return url
    p = unquote(urlparse(url).path)
    if re.match(r"^/[A-Za-z]:", p):
        p = p[1:]
    return p
