#!/usr/bin/env python

import glob
import os
import shutil
import sys

zip_prefix = 'BitersBegoneUpdated'

if __name__ == '__main__':
    new_versions = glob.glob(zip_prefix + "*")
    new_versions.sort(key=os.path.getmtime)
    if len(new_versions) == 0:
        print("Cannot find a version of " + zip_prefix + " to install")
        sys.exit(1)

    latest_version = new_versions[-1]
    print("Installing " + latest_version)

    dest = "../../../AppData/Roaming/Factorio/mods"
    
    existing = glob.glob(os.path.join(dest, zip_prefix + "*"))
    if len(existing) > 0:
        print("Removing existing versions: " + " ".join(existing))
        for i in existing:
            os.unlink(i)

    shutil.copy(latest_version, os.path.join(dest, latest_version))
