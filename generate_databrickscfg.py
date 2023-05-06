def get_workspaces():
    import os, gspread_pandas as gsp
    os.environ['GSPREAD_PANDAS_CONFIG_DIR'] = os.getcwd()  # Location of google_secret.json
    spreadsheet = gsp.Spread('1psGBLvYOp8IGptQZmbNYqHrQ57q2Y2HzWoQ24KPwxE4')  # Partner CoLab
    df = spreadsheet.sheet_to_df(sheet='Workspaces')
    return df.to_dict(orient='records')

def decrypt(encrypted_token):
    from dotenv import load_dotenv
    from cryptography.fernet import Fernet
    import os
    load_dotenv()
    key = os.environ.get('FERNET_KEY')
    f = Fernet(key)
    return f.decrypt(encrypted_token)

def get_databrickscfg(workspaces):
    import configparser, sys
    config = configparser.ConfigParser()
    for workspace in workspaces:
        name = 'colab_' + workspace['Endpoint'].replace('enb-', '').replace('.cloud.databricks.com', '')
        config[name] = {
            'host': 'https://' + workspace['Endpoint'],
            'jobs-api-version': 2.0,
            'token': decrypt(workspace['Encrypted Token']).decode()
        }
    config.write(sys.stdout)

get_databrickscfg(get_workspaces())