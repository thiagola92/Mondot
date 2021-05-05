## Should i put my script here?
The script should be the closest from the nodes that it use.  

* If the script reference any parent node, no.
  * Don't access parent with `get_node("..")` or `$".."`, move your script to the parent.
* If can move the script to a child, no.
  * If a child can have the script without breaking any of the rules above, move your script to the child.
