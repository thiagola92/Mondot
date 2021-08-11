import ast


class Code:
    @staticmethod
    def rewrite_user_code(input_path, output_path):
        user_code = Code._parse_user_code(input_path)
        base_code = Code._parse_base_code()

        Code._inject_inside_base_code(base_code, user_code)
        Code._recalculate_lines_and_columns_positions(base_code)
        Code._write_output(output_path, base_code)

    @staticmethod
    def _parse_user_code(input_path):
        with open(input_path, "r") as f:
            return ast.parse(f.read())

    @staticmethod
    def _parse_base_code():
        return ast.parse("def code(self):\n" "    return self")

    @staticmethod
    def _inject_inside_base_code(base_code, user_code):
        function = base_code.body[0]

        # Insert all user code inside the function
        # and add a return to the last expression
        function.body = [exp for exp in user_code.body]
        function.body[-1] = ast.Return(value=function.body[-1].value)

    @staticmethod
    def _recalculate_lines_and_columns_positions(first_node):
        attributes_to_remove = ["lineno", "end_lineno", "col_offset", "end_col_offset"]

        # Remove attributes so they can be recalculated
        for node in ast.walk(first_node):
            node._attributes = tuple(
                attribute
                for attribute in node._attributes
                if attribute not in attributes_to_remove
            )

        # Recalculate attributes
        ast.fix_missing_locations(first_node)

    @staticmethod
    def _write_output(output_path, base_code):
        with open(output_path, "w") as f:
            f.write(ast.unparse(base_code))
