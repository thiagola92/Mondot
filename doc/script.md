## Should i put my script here?
The script should be the closest from the nodes that it use.  

* If the script reference any parent node, no.
  * Don't access parent with `get_node("..")` or `$".."`, move your script to the parent.
* If can move the script to a child, no.
  * If a child can have the script without breaking any of the rules above, move your script to the child.

## How should i name my script file?
Follow godot style guide and use snake_case for scripts names.  
Use the node name as base for the script.  

For example, this is your scene:  
```markdown
* Container
  * Menu
    * NewFolder
    * NewConnection
  * Tree
```

If every node in this scene had a script for your own use, they would be called `container.gd`, `menu.gd`, `new_folder.gd`, `new_connection.gd` and `tree.gd`.  

In case two nodes have the same name, you should use the parent in the name too. For example:  
```markdown
* Container
  * Menu
    * NewFolder
    * NewConnection
  * Tree
    * Menu
```

The node from path `Container/Menu` would be called `menu.gd`.  
The node from path `Container/Tree/Menu` would be called `tree_menu.gd`.  