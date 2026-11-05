<h1 align="center">
      H-BOX
</h1>

[DOWNLOAD from github](https://github.com/alishanjack/h-box/releases) or [DOWNLOAD from gofile.io](https://gofile.io/d/44fq12)
# [中文](https://github.com/alishanjack/h-box/blob/main/README.md) | English
# H-BOX manual
## H-BOX introduce
- Home<br>
   Downloaded videos will be displayed here.<br>
    Page turning function, jump function, search function, editing function, not to repeat.
- Player<br>
  Click the card on the home page to pop up the playback page<br>
  Clicking the image button will generate a video preview image in the background<br>
  Click the heart button to bookmark the video<br>
  fast forward, volume adjustment
- Collect<br>
  The favorites on the home page will be displayed here, click to play<br>
- TAg<br>
  for video classification<br>
  Add button, edit button, delete button, title description, background image.
- History<br>
  The videos played on the home page are recorded here, click to play them, and jump directly to the last playback point.
- Internet download<br>
  **The premise of downloading is that your network can access this website, and the software does not need to configure a proxy.**<br>
  From the interface downloaded from the website, if you want to download the video, you only need to copy the link of the play page to
  enter the box and click Enter. See below for specific operationsg video。
  **！！！Notice！！！**<br>
  Remember to click the synchronization button on the far right to synchronize your chrome user data to the software directory，
  In this way, selenium can easily avoid the detection of some verification codes when requesting websites, such as cloudflare verification,
  Twitter needs to log in to cooikes for verification to download videos. You log in to chrome and then sync to selenium
  to request twitter is to log in, and it is easy to grab the video link
- Setting<br>
  Language switching currently supports Chinese and English<br>
  The data directory controls where the downloaded videos are stored, and must be an absolute path. It is recommended not to change this, it is more troublesome to chang.
- Rule analysis<br>
  The parsing rules judge the corresponding rules through the domain name. If a website has multiple domain names, separate them with ','.<br>
  type controls whether the download is an m3u8 link or an mp4 link<br>
  Regular matching of video resource paths, multiple resources are separated by ','
  pic.re the xpath path of the cover pic.value the value of the element
  Icon corresponding to ico
  ...<br>
  Develop more rule types and applications Please join the discussion group to discuss and learn😁 [t.me/h-box](https://t.me/hboxapp)
- Finally<br>
  Like-minded welcome to exchange.
- Gif<br>
  ## H-BOX way of working
- h-boxMainly obtain three things from the target website, video title, video cover, video resource link.
- h-box Obtaining video links is not parsing html like ordinary crawlers to obtain resource links.
  Instead, resources are obtained by monitoring all links sent by the web page and matching regular rules in the rules.
  So you can write your own rules to download unsupported websites in h-box.
  The title and cover are obtained by parsing html but also based on written rules, 
  which is very simple. Currently supported video link formats are m3u8 and mp4。
- h-box Use selenium to work in headless mode and non-headless mode (the interface can be selected),
  Some websites cannot load resources at all in headless mode, and can only choose non-headless mode to manually trigger the webpage to send a video link.
  This is the main principle。
## H-BOX running needs
- chrome, chrome driver, ffmpeg. (chrome driver, ffmpeg) these are already included in the installation package.
  If the chrome drive does not match your chrome version, please download the corresponding driver and replace it in the installation directory.
