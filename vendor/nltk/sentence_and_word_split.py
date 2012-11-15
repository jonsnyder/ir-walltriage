import json
import fileinput
from nltk.tokenize import sent_tokenize
from nltk.tokenize import word_tokenize

for line in fileinput.input():
  try:
    o = json.loads( line)
    if o['text']:
      sentences = sent_tokenize( o['text'])
      for sentence in sentences:
        o['text'] = sentence
        print json.dumps( o)
  except ValueError:
    pass

