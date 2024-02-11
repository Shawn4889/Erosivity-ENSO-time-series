import requests
import subprocess
import os

a = 0
username = "xxl164030"
password = "Lxx47944889"
space = r'E:\temp\NewIdea\FIKData\data\rainfall'
NetCDFfile = space + "\\Ori.txt"
OutNetCDFfile = space + "\\Ori.txt"

# Grab the data on NASA's website
# noinspection PyBroadException
try:
    class SessionWithHeaderRedirection(requests.Session):
        AUTH_HOST = 'goldsmr4.gesdisc.eosdis.nasa.gov'
        def __init__(self, username, password):
            super().__init__()
            self.auth = (username, password)
        # Overrides from the library to keep headers when redirected to or from the NASA auth host.
        def rebuild_auth(self, prepared_request, response):
            headers = prepared_request.headers
            url = prepared_request.url
            if 'Authorization' in headers:
                original_parsed = requests.utils.urlparse(response.request.url)
                redirect_parsed = requests.utils.urlparse(url)
                if (original_parsed.hostname != redirect_parsed.hostname) and \
 \
                        redirect_parsed.hostname != self.AUTH_HOST and \
 \
                        original_parsed.hostname != self.AUTH_HOST:
                    del headers['Authorization']
            return
    session = SessionWithHeaderRedirection(username, password)
    with open(NetCDFfile) as f:
       for line in f:
           filename = line[158:169]
           print(filename)
           # submit the request using the session
           response = session.get(line, stream=True)
           # raise an exception in case of http errors
           response.raise_for_status()
           # save the file
           with open(filename, 'wb') as fd:
               for chunk in response.iter_content(chunk_size=1024 * 1024):
                   fd.write(chunk)
           a = a + 1
    print("All NetCDF files downloaded!")
except Exception as ex:
    print("Crashed, try to restart...")

#Restart
lines = open(NetCDFfile).readlines()
os.remove(NetCDFfile)
open(OutNetCDFfile, 'w').writelines(lines[a:])

while True:
    print("Restarted")
    subprocess.call(['python.exe', 'E:\\temp\\NewIdea\\FIK\\ENSO.py', 'htmlfilename.htm'])