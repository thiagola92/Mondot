from pymongo import MongoClient
from mondot.pages import Pages
from pymongo.cursor import Cursor


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
        if self._cant_navegate_with_for(obj):
            obj = [obj]  # Now it can navegate with a for
        self._save_output(obj)

    def _cant_navegate_with_for(self, obj):
        valid_types = (list, tuple, set, Cursor)

        return not isinstance(obj, valid_types)

    def _save_output(self, obj):
        for doc in obj:
            self._pages.append_document(doc)
        self._pages.write_page()
