import Foundation

// Create an new instance of OvalShape type named circle with width and height of 150
let circle = OvalShape(width:150, height: 150)

/*
The setup() function is called once when the app launches. Without it, your app won't compile.
Use it to set up and start your app.

You can create as many other functions as you want, and declare variables and constants,
at the top level of the file (outside any function). You can't write any other kind of code,
for example if statements and for loops, at the top level; they have to be written inside
of a function.
*/

func setup() {
    
    // create a new instance of Point and assign to position property of circle
    // which defines its location on the screen using x and y coordinates
    circle.position = Point(x:250, y: 400)
    
    // the scene instance represents the white area on the screen,
    // using add method to put circle into the scene
    scene.add(circle)
}
