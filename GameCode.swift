import Foundation

// declare a new variable to store the array of multiple barriers
var barriers: [Shape] = []

// create multiple targets - array of targets variable declartion
var targets: [Shape] = []

// Create an new instance of OvalShape type named circle with width and height of 150
let ball = OvalShape(width:40, height: 40)

// define the width and height of the barrier
//let barrierWidth = 300.0
//let barrierHeight = 25.0
//
// create an array of Point instances to describe the barriers four corners
//let barrierPoints = [
//    Point(x: 0, y: 0),
//    Point(x: 0, y: barrierHeight),
//    Point(x: barrierWidth, y: barrierHeight),
//    Point(x: barrierWidth, y: 0)
//]

// create a new PolygonShape instance whose initializer requires an array
// of points the defines its vertices.
//let barrier = PolygonShape(points: barrierPoints)

// Add a funnel, a new shape to represent through which ball drops
let funnelPoints = [
    Point(x:0, y: 50),
    Point(x:80, y:50),
    Point(x:60, y: 0),
    Point(x: 20, y: 0)
]
let funnel = PolygonShape(points: funnelPoints)

// Add a target shape
//let targetPoints = [
//    Point(x: 10, y: 0),
//    Point(x: 0, y: 10),
//    Point(x: 10, y: 20),
//    Point(x: 20, y: 10)
//]
//let target = PolygonShape(points: targetPoints)


/*
The setup() function is called once when the app launches. Without it, your app won't compile.
Use it to set up and start your app.

You can create as many other functions as you want, and declare variables and constants,
at the top level of the file (outside any function). You can't write any other kind of code,
for example if statements and for loops, at the top level; they have to be written inside
of a function.
*/

fileprivate func setupBall() {
    // create a new instance of Point and assign to position property of circle
    // which defines its location on the screen using x and y coordinates
    ball.position = Point(x:250, y: 400)
    
    // the scene instance represents the white area on the screen,
    // using add method to put circle into the scene
    scene.add(ball)
    
    // hasPhysics property determines whther it particpates in physics simulation
    // as the ball accelerates downwards as physics would dictate
    ball.hasPhysics = true
    
    // fillColor property is a type Color
    // change ball color to blue
    ball.fillColor = .blue
    
    // dont allow user to move or drage the ball
    ball.isDraggable = false
    
    // make a bouncier ball
    ball.bounciness = 0.6
    
    ball.onCollision = ballCollided(with:)
    
    // keep track of ball and call function ballExitedScene
    // to allow user to to move barrier since ball exited scene
    // or not in play
    scene.trackShape(ball)
    ball.onExitedScene = ballExitedScene

    // move ball below scene after ball drops to allow user to move barriers
    ball.onTapped = resetGame
}

fileprivate func addBarrier(at position: Point, width: Double, height: Double, angle: Double) {
    
    let barrierPoints = [
        Point(x: 0, y: 0),
        Point(x: 0, y: height),
        Point(x: width, y: height),
        Point(x: width, y: 0)
    ]
    
    // create shape and size or parameters for the barrier
    let barrier = PolygonShape(points: barrierPoints)
    
    barriers.append(barrier)
    
    // Add a barrier to the scene.
    //barrier.position = Point(x: 370, y: 422)
    barrier.position = position
    barrier.hasPhysics = true
    // tilt the barrier
    //barrier.angle = 0.1
    barrier.angle = angle
    scene.add(barrier)
    
    // change barrier fillColor property to color red
    barrier.fillColor = .red
    
    // use property isImmobile so the barrier shape doesnt move
    barrier.isImmobile = true
}

fileprivate func setupFunnel() {
    // Add a funnel to the scene
    // use property height to position the funnel at the top of the screen
    funnel.position = Point(x: 200, y: scene.height - 25)
    scene.add(funnel)
    
    // the onTapped property of a shape has a type of a function.
    // Any function can be called as long as there are no parameters
    // or returns
    funnel.onTapped = dropBall
    funnel.fillColor = .gray
    
    // missing in instructions of the book
    // add so user cant move the funnel
    funnel.isDraggable = false
}

func addTarget(at position: Point) {
    let targetPoints = [
        Point(x: 10, y: 0),
        Point(x: 0, y: 10),
        Point(x: 10, y: 20),
        Point(x: 20, y: 10)
    ]
    
    let target = PolygonShape(points: targetPoints)
    
    targets.append(target)
    
    // target.position = Point(x: 200, y: 400)
    target.position = position
    
    target.hasPhysics = true
    target.isImmobile = true
    target.isImpermeable = false
    target.fillColor = .yellow
    target.name = "target"
    
    target.isDraggable = false
    
    scene.add(target)
}

// Handles collisions between the ball and the targets.
func ballCollided (with otherShape: Shape){
    if otherShape.name != "target" { return }
    
    otherShape.fillColor = .green
}

// Call function for when ball exits the scene
func ballExitedScene(){
    
    // track how many targets the user hits after dropping ball
    var hitTargets = 0
    for target in targets {
        if target.fillColor == .green {
            hitTargets += 1
        }
    }
    // number of targets hit equals the array size of all targets
    // then all targets were hit in one try
    print ("hitTargets = \(hitTargets)")
    print ("targets.count = \(targets.count)")
    if hitTargets == targets.count {
        // print ("Won game!")
        scene.presentAlert(text: "You won!",completion: alertDismissed)
    }
    func alertDismissed () {
    }
    
    // allow user to move barrier since ball is not in play
    for barrier in barriers {
        barrier.isDraggable = true
    }
}

// Resest the game by moving the ball below the scene,
// which will unlock the barriers.
func resetGame() {
    ball.position = Point (x:  0, y: -80)
}

//
func printPosition (of shape: Shape) {
    print(shape.position)
}

func setup() {
    
    setupBall()
    setupFunnel()
    
    //add barriers to the scene
    addBarrier(at: Point(x: 200, y: 150), width: 80, height:25, angle: 0.1)
    addBarrier(at: Point(x: 100, y: 150), width: 30, height:15, angle: -0.2)
    addBarrier(at: Point(x: 300, y: 150), width: 100, height:25, angle: 0.03)
    
    // add a target to the scene
    addTarget(at: Point(x:133, y: 614))
    addTarget(at: Point(x:111, y: 474))
    addTarget(at: Point(x:256, y: 280))
    addTarget(at: Point(x:151, y: 242))
    addTarget(at: Point(x:165, y: 40))
    
    // print the position every time a shape is moved
    scene.onShapeMoved = printPosition(of:)
    
    // Resest the game by moving the ball below the scene,
    // which will unlock the barriers.
    resetGame()
        
}


// Drops the ball by moving it to the funnels position
func dropBall() {
    
    // every time the ball drops, rest all targets so user
    // has to hit them all on one try to win game
    for target in targets {
        target.fillColor = .yellow
    }
    
    // dont allow player to move barrier while ball is in play
    for barrier in barriers {
        barrier.isDraggable = false
    }
    
    ball.position = funnel.position
    
    // every time you tap the funnel the ball exits with greater speed
    ball.stopAllMotion()
}
