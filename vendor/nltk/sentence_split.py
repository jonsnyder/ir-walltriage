import json
import fileinput
from nltk.tokenize import sent_tokenize


for line in fileinput.input():
  try:
    o = json.loads( line)
    if o['text']:
      o['split'] = sent_tokenize( o['text'])
      print json.dumps( o)
  except ValueError:
    pass

