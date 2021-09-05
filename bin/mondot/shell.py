from pymongo import MongoClient
from mondot.pages import Pages
from collections.abc import Iterable


class Shell:
    def __init__(self, uri, db, filepath, page_size, *args, **kwargs):
        self.uri = uri
        self.client = MongoClient(self.uri)
        self.db = self.client[db]

        self._pages = Pages(filepath, int(page_size))

    def run(self, code):
        try:
            obj = code(self)
        except Exception as e:
            obj = f"{type(e).__name__}: {str(e)}"
            self._pages.error = True
        
        self._process_output(obj)

    def _process_output(self, obj):
        # Prevent iterating a string
        if isinstance(obj, str):
            obj = [obj]
        
        # Make sure that the obj is iterable at the end
        if not isinstance(obj, Iterable):
            obj = [obj]
        
        self._save_output(obj)

    def _save_output(self, obj):
        for doc in obj:
            self._pages.append_document(doc)
        self._pages.write_page()
