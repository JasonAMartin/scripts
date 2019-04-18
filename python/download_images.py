# Python example for downloading a list of images - Wikimedia used as example
import http.client
import contextlib
path_list = [
       "/wikipedia/commons/7/72/IPhone_Internals.jpg",
       "/wikipedia/en/c/c1/1drachmi_1973.jpg",
]
host = "upload.wikimedia.org"

myHeaders = {'User-Agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 7_1_1 like Mac OS X) AppleWebKit/537.51.2 (KHTML, like Gecko) Version/7.0 Mobile/11D201 Safari/9537.53'}

with contextlib.closing(http.client.HTTPConnection( host )) as connection:
       for path in path_list:
          connection.request( "GET", path, headers = myHeaders )
          response= connection.getresponse()
          print("Status:", response.status)
          print("Headers:", response.getheaders())
          _, _, filename = path.rpartition("/")
          print("Writing:", filename)
          with open(filename, "wb") as image:
              image.write( response.read() )
