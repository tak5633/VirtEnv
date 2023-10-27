#---------------------------------------------------------------------------------------------------
#
#---------------------------------------------------------------------------------------------------

import configparser
import os
import sys

#---------------------------------------------------------------------------------------------------
#
#---------------------------------------------------------------------------------------------------
def DoesPipCertFileExist(pPipConfFilename: str) -> int:

   exists = False

   config = configparser.ConfigParser()
   config.read(pPipConfFilename)

   try:
      exists = os.path.isfile(config["global"]["cert"])
   except:
      pass

   if not exists:
      sys.exit(1)

   sys.exit(0)
