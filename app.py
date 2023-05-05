encrypted_token = ''
import os
from dotenv import load_dotenv
load_dotenv()
key = os.environ.get('FERNET_KEY')
colab = os.environ.get('ENB_COLAB')

from cryptography.fernet import Fernet
f = Fernet(key)
print(f.decrypt(colab))