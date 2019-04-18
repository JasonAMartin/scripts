# Example of hitting an API and creating JSON in Python

import urllib.request
import json
query_currencies= "https://api.coinbase.com/v2/currencies"

with urllib.request.urlopen( query_currencies ) as document:
  print(document.info().items())
  currencies= json.loads( document.read().decode("utf-8") )
  print(currencies)
