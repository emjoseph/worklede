from pdfminer.pdfinterp import PDFResourceManager, PDFPageInterpreter
from pdfminer.converter import TextConverter
from pdfminer.layout import LAParams
from pdfminer.pdfpage import PDFPage
from pdfminer.pdfparser import PDFParser
from pdfminer.pdfdocument import PDFDocument
from io import StringIO
from pyresparser import ResumeParser
import spacy
from spacy.matcher import Matcher
import re
from spacy.gold import GoldParse 
from spacy.pipeline import EntityRecognizer 

# Constants
CONST_EXPERIENCE = 'experience'
CONST_EDUCATION = 'education'
CONST_SKILLS = 'skills'
CONST_EDUQLF = 'educational qualifications'
CONST_QLF = 'qualifications'

class Resume:
    name = ''
    emails = []
    phones = []
    experience = ''
    education = ''
    awards = ''
    skills = ''
    def __init__(self):
        super().__init__()

class NLP:
    nlp_spacy = None
    def __init__(self):
        self.nlp_spacy = spacy.load("en_core_web_sm")

def convert_pdf_to_txt(path):
    rsrcmgr = PDFResourceManager()
    retstr = StringIO()
    #codec = 'utf-8'
    laparams = LAParams()
    device = TextConverter(rsrcmgr, retstr, laparams=laparams)

    fp = open(path, 'rb')

    parser = PDFParser(fp)
    doc = PDFDocument(parser)
    parser.set_document(doc)

    interpreter = PDFPageInterpreter(rsrcmgr, device)
    password = ""
    maxpages = 0
    caching = True
    pagenos=set()

    for page in PDFPage.get_pages(fp, pagenos, maxpages=maxpages,
                                 password=password,caching=caching,
                                 check_extractable=True):
        interpreter.process_page(page)

    text = retstr.getvalue()

    fp.close()
    device.close()
    retstr.close()
    #print(text)
    return text

def get_doc(text):
    nlp = NLP()
    doc = nlp.nlp_spacy(text)
    return doc

def get_insights_from_resume(resume_text):
    '''
    Different sections of the resume can be Professional Experience (or Journalism Experience or just Experience or Additional Experience,
    Technical Skills or just Skills, Education, Related Coursework or Relevant Coursework or just Coursework, Honors and Achievements
    '''
    
    resume = Resume()
    # getting email
    emails = re.findall(r'[A-Za-z0-9_]+\@\S+\.[A-Za-z]+', resume_text)
    print(emails)
    resume.emails = emails
    # getting phone numbers
    phones = re.findall(r'\(?\d{3}\)?[-.\s]\d{3}[-.\s]\d{4}', resume_text)
    print(phones)
    resume.phones = phones
    # matcher = Matcher(nlp.vocab, validate=True)
    # matcher.add("RESUME", callback(), [{"LOWER": "education"}], [{"LOWER": "experience"}], [{"LOWER": "skills"}],
    #                                         [{"LOWER": "awards"}], [{"LOWER": "campus"}, {"LOWER": "involvement"}],
    #                                         [{"LOWER": "honors"}], [{"LOWER": "projects"}], [{"LOWER": "languages"}],
    #                                         [{"LOWER": "references"}], [{"LOWER": "educational"}, {"LOWER": "qualifications"}],
    #                                         [{"LOWER": "leadership"}], [{"LOWER": "work"}, {"LOWER": "history"}])

    doc = get_doc(resume_text)
    lines = [el.strip() for el in resume_text.split('\n') if len(el) > 0]
    experience_bucket = ' '
    token_exp = None
    education_bucket = ' '
    token_edu = None
    skills_bucket = ' '
    token_skills = None
    for line in lines:
        # finding out for each line if there are any pattern matches
        if re.search(CONST_EXPERIENCE, line, re.IGNORECASE):
            # start tracking experience from here
            # get the token id 
            token_exp = [(token.text,token.i) for token in doc if token.text.lower() == CONST_EXPERIENCE][0]
        elif re.search(CONST_EDUCATION, line, re.IGNORECASE):
            token_edu = [(token.text,token.i) for token in doc if token.text.lower() == CONST_EDUCATION][0]
        elif re.search(CONST_EDUQLF, line, re.IGNORECASE):
             token_edu = [(CONST_EDUCATION,token.i) for token in doc if token.text.lower() == CONST_QLF][0]
        elif re.search(CONST_SKILLS, line, re.IGNORECASE):
            token_skills = [(token.text,token.i) for token in doc if token.text.lower() == CONST_SKILLS][0]
        else:
            continue

    # sort the tokens
    tokens = [token_exp, token_edu, token_skills]
    print(token_exp, token_edu, token_skills)
    tokens.sort(key = lambda x: x[1])  
    # iterate over tokens
    for index, token_tup in enumerate(tokens):
        if token_tup[0].lower() == CONST_EXPERIENCE:
            if index < len(tokens) - 1:
                experience_tups = [(token.text,token.i) for token in doc if token.i > token_tup[1] and token.i < tokens[index+1][1]]
            else:
                experience_tups = [(token.text,token.i) for token in doc if token.i > token_tup[1]]
            experience_bucket = experience_bucket.join([tup[0] for tup in experience_tups])
        elif token_tup[0].lower() == CONST_EDUCATION:
            if index < len(tokens) - 1:
                education_tups = [(token.text,token.i) for token in doc if token.i > token_tup[1] and token.i < tokens[index+1][1]]
            else:
                education_tups = [(token.text,token.i) for token in doc if token.i > token_tup[1]]
            education_bucket = education_bucket.join(([tup[0] for tup in education_tups]))
        elif token_tup[0].lower() == CONST_SKILLS:
            if index < len(tokens) - 1:
                skills_tups = [(token.text,token.i) for token in doc if token.i > token_tup[1] and token.i < tokens[index+1][1]]
            else:
                skills_tups = [(token.text,token.i) for token in doc if token.i > token_tup[1]]
            skills_bucket = skills_bucket.join(([tup[0] for tup in skills_tups]))
    
    resume.experience = experience_bucket
    resume.education = education_bucket
    resume.skills = skills_bucket
    

    # extract_entities(experience_bucket)
    extract_entities(skills_bucket)

    return resume

def extract_entities(str):
    '''
    Extracts entitities from text
    '''
    doc = get_doc(str)
    # print noun chunks
    print([chunk.text for chunk in doc.noun_chunks])
    # print entities
    for ent in doc.ents:
        print(ent.text, ent.label_)
            


resume_text = convert_pdf_to_txt('Resume_Bhaskar.pdf')
get_insights_from_resume(resume_text)




