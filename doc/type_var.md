## Should i declare the variable type?

* If is a function argument, yes.
  * Who is calling the function should know the type you are expecting and declaring the type help them.
* If is a function local variable, no.
  * Inside the function scope you can deduce the variable type from the argument or functions returns, because they should have their variable type declared.