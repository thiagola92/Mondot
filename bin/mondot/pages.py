import time
from bson import json_util


class Pages:
    def __init__(self, filepath, page_size):
        self._filepath = filepath
        self._page_size = page_size

        self._current_page = 1
        self._current_docs = []

    def append_document(self, doc):
        self._current_docs.append(doc)

        if len(self._current_docs) >= self._page_size:
            self.write_page()
            self._wait_mondot_input()

    def write_page(self):
        filename = f"{self._filepath}_{self._current_page}"

        # Doesn't need to write file when no document exist
        if len(self._current_docs) <= 0:
            return

        with open(filename, "w") as file:
            file.write(
                json_util.dumps(
                    self._current_docs,
                    indent=2,
                    json_options=json_util.STRICT_JSON_OPTIONS,
                )
            )

        self._start_new_page()

    def _start_new_page(self):
        self._current_page += 1
        self._current_docs.clear()
    
    def _wait_mondot_input(self):
        filename = f"{self._filepath}_i"

        self._clean_mondot_input(filename)

        while self._read_mondot_input(filename) == "":
            time.sleep(1)
    
    def _clean_mondot_input(self, filename):
        with open(filename, 'w') as f:
            f.write("")
        
    def _read_mondot_input(self, filename):
        with open(filename, 'r') as f:
            return f.read()
