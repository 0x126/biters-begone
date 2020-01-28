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
    version_name = zip_prefix + "_" + version
    zipname = version_name + '.' + zip_suffix
    print("Building %s" % zipname)
    with zipfile.ZipFile(zipname, 'w', zipfile.ZIP_DEFLATED) as zout:
        for root, dirs, files in os.walk('.'):
            if '.git' in dirs:
                dirs.remove('.git')
            for f in files:
                if re.match(zip_prefix + '.*' + zip_suffix, f):
                    continue
                fullname = os.path.join(root, f)
                newname = os.path.normpath(os.path.join(version_name, root, f))
                print("%s -> %s" % (fullname, newname))
                zout.write(fullname, arcname=newname)

