#!/usr/bin/env python
import json
import os
import re
import zipfile

zip_prefix = 'BitersBegoneUpdated'
zip_suffix = 'zip'

if __name__ == '__main__':
    with open("info.json") as fin:
        version = json.load(fin)['version']
    zipname = zip_prefix + '_' + version + '.' + zip_suffix
    print("Building %s" % zipname)
    with zipfile.ZipFile(zipname, 'w', zipfile.ZIP_DEFLATED) as zout:
        for root, dirs, files in os.walk('.'):
            if '.git' in dirs:
                dirs.remove('.git')
            for f in files:
                if re.match(zip_prefix + '.*' + zip_suffix, f):
                    continue                
                fullname = os.path.join(root, f)
                print(fullname)
                zout.write(fullname)

