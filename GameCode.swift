import Foundation

// Create an new instance of OvalShape type named circle with width and height of 150
let circle = OvalShape(width:150, height: 150)

// define the width and height of the barrier
let barrierWidth = 300.0
let barrierHeight = 25.0

// create an array of Point instances to describe the barriers four corners
let barrierPoints = [
    Point(x: 0, y: 0),
    Point(x: 0, y: barrierHeight),
    Point(x: barrierWidth, y: barrierHeight),
    Point(x: barrierWidth, y: 0)
]

// create a new PolygonShape instance whose initializer requires an array
// of points the defines its vertices.
let barrier = PolygonShape(points: barrierPoints)

//Add a funnel, a new shape to represent through which ball drops
let funnelPoints = [
    Point(x:0, y: 50),
    Point(x:80, y:50),
    Point(x:60, y: 0),
    Point(x: 20, y: 0)
]
let funnel = PolygonShape(points: funnelPoints)

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
    
    // hasPhysics property determines whther it particpates in physics simulation
    // as the ball accelerates downwards as physics would dictate
    circle.hasPhysics = true
    
    
    // Add a barrier to the scene.
    barrier.position = Point(x: 200, y: 150)
    barrier.hasPhysics = true
    scene.add(barrier)
    
    // use property isImmobile so the barrier shape doesnt move
    barrier.isImmobile = true
    
    
    // Add a funnel to the scene
    // use property height to position the funnel at the top of the screen
    funnel.position = Point(x: 200, y: scene.height - 25)
    scene.add(funnel)
    
    // the onTapped property of a shape has a type of a function.
    // Any function can be called as long as there are no parameters
    // or returns
    funnel.onTapped = dropBall
}


// Drops the ball by moving it to the funnels position
func dropBall() {
    circle.position = funnel.position
}
