import requests
import argparse

parser = argparse.ArgumentParser(description='get url status')
parser.add_argument("--url", required=True, help="add url")
parser.add_argument("--list", required=True, help="list of names to check")
args = parser.parse_args()

try:
    r = requests.head(args.url)
    print(r.status_code)
    # prints the int of the status code. Find more at httpstatusrappers.com :)
except requests.ConnectionError:
    print("failed to connect")
