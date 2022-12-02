### Import Libraries

import pandas as pd
from pathlib import Path
import numpy as np
import plotly.express as px
####End of importing libraries


pathCurrrent = Path.cwd()
from sqlalchemy import create_engine


# engine = create_engine('mysql+pymysql://root:1333@localhost/codetest')

import datetime
def validate(date_text):
        try:
            datetime.datetime.strptime(date_text, '%Y-%m-%d')
        except ValueError:
            raise ValueError("Incorrect data format, should be YYYY-MM-DD")

from dateutil.parser import parse

from datetime import datetime


pathCurrrent = str(pathCurrrent).replace("\\", '/')


dfs = pd.read_csv(pathCurrrent+"/data/SARS-CoV.csv")

dates=["DATE_DRAW", "RECEIVE_DATE", "PROCESSING_DATE"]


 # Find out all the unique values that do not fit the specified format JJJJ-MM-TT
for date in dates:

    m = pd.to_datetime(dfs[date], format='%Y-%m-%d', errors='coerce').isna()

    print (f"\n Unique row values: {dfs.loc[m, date].unique().tolist()} \n")


diagLab=dfs.groupby(['SENDING_LAB_PC']).size().reset_index(name='counts')

seqLab=dfs.groupby(['SEQUENCING_LAB_PC']).size().reset_index(name='counts')


dfs["SENDING_LAB_PC"]   =    dfs["SENDING_LAB_PC"].round(decimals=0).astype(object)

dfs["SEQUENCING_LAB_PC"]=    dfs["SEQUENCING_LAB_PC"].round(decimals=0).astype(object)



# Create Distribution of the labs
figSENDING = px.histogram(diagLab, x="SENDING_LAB_PC" , y="counts")
figSENDING.update_xaxes(type='category')
figSENDING.show()

figSENDING.update_layout(
    title="Distribution of the SENDING labs"
)

figSENDING.write_html("Dist_SENDING_LAB_PC.html")



figseqLab = px.histogram(seqLab, x="SEQUENCING_LAB_PC" , y="counts")
figseqLab.update_xaxes(type='category')
figseqLab.show()

figseqLab.update_layout(
    title="Distribution of the seqLab labs"
)

figSENDING.write_html("Dist_SEQUENCING_LAB_PC.html")



print ("Case Study IMS Data Engineer Project finished. \n")









