from io import StringIO
import spacy
from spacy.matcher import Matcher
import re
from spacy.gold import GoldParse
from spacy.pipeline import EntityRecognizer
import json
import sys
import requests
import os

nlp = spacy.load("en_core_web_sm")

job_text = sys.argv[1]
resume_text = sys.argv[2]

doc1 = nlp(job_text)
doc2 = nlp(resume_text)
score = doc1.similarity(doc2)
print(score)
