import os
import argparse
import importlib.util
from pathlib import Path
from mondot.code import Code
from mondot.shell import Shell


# Example: bin/python bin/run.py --filepath "bin/input.py" --output "bin/tmp.py"
parser = argparse.ArgumentParser(description="Description to be used on mondot")

parser.add_argument("--uri", dest="uri", default="mongodb://127.0.0.1:27017")
parser.add_argument("--database", dest="db", default="admin")
parser.add_argument("--filepath", dest="filepath")
parser.add_argument("--output", dest="outpout", default="tmp.py")
parser.add_argument("--page_size", dest="page_size", default=20)

args = parser.parse_args()
args = vars(args)
args["filepath"] = str(Path(args["filepath"]).resolve())  # Absolute path
args["outpout"] = str(Path(args["outpout"]).resolve())  # Absolute path

Code.rewrite_user_code(input_path=args["filepath"], output_path=args["outpout"])

# Import temporary code
spec = importlib.util.spec_from_file_location("temporary_code", args["outpout"])
module = importlib.util.module_from_spec(spec)
spec.loader.exec_module(module)

os.remove(args["outpout"])  # Remove temporary code because it's already loaded

Shell(**args).run(module.code)
