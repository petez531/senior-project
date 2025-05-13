package main

import "core:fmt"
import "core:math/rand"
import "core:math"
import "core:time"
import "vendor:raylib"

SCREEN_WIDTH :: 800
SCREEN_HEIGHT :: 450
PEG_AMOUNT :: 50
GRAVITY :: 500
BALL_YSPEED :: 200
BALL_XSPEED :: 200
BALL_START_X_POS :: 400
BALL_START_Y_POS :: 50
BALL_SIZE :: 5
PEG_SIZE :: 5

Peg :: struct {
    x: i32,
    y: i32,
    activated: bool,
}

Ball :: struct {
    xpos: f32,
    ypos: f32,
    xspeed: f32,
    yspeed: f32,
    isActive: bool,
}

// Randomly generates postions for pegs
generatePegs :: proc() -> (pegs: [PEG_AMOUNT]Peg){
    for i in 0..<len(pegs) {
        x := 50 + rand.int31_max(700)
        y := 75 + rand.int31_max(350)

        pegs[i] = Peg{x, y, true}
    }

    return pegs
}

// Draws each peg in the list at their position
drawPegs :: proc(pegs: [PEG_AMOUNT]Peg) {
    for peg in pegs {
        if peg.activated {
            raylib.DrawCircle(peg.x, peg.y, PEG_SIZE, raylib.BLACK)
        }
    }
}

// Draws a ball at the balls position
drawBall :: proc(ball: Ball) {
    raylib.DrawCircle(i32(ball.xpos), i32(ball.ypos), BALL_SIZE, raylib.RED)
}

// Gets the angle between the ball and the mouse position
getBallAngle :: proc(mouse_xpos: f32, mouse_ypos: f32) -> f32{
    return math.atan((mouse_xpos - BALL_START_X_POS) / (mouse_ypos - BALL_START_Y_POS))
}

main :: proc() {
    raylib.InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "Window")
    raylib.SetTargetFPS(30)

    pegs := generatePegs()
    ball := Ball{BALL_START_X_POS, BALL_START_Y_POS, 0, 0, false}


    for !raylib.WindowShouldClose() {
        deltaTime := raylib.GetFrameTime()
        
        // Update
        mouse_xpos := f32(raylib.GetMouseX())
        mouse_ypos := f32(raylib.GetMouseY())
        mouse_angle := getBallAngle(mouse_xpos, mouse_ypos)


        // Activates the ball
        if raylib.IsMouseButtonPressed(.LEFT) && !ball.isActive{
            ball.isActive = true
            ball.yspeed = BALL_YSPEED
            ball.xspeed = BALL_XSPEED * mouse_angle
        }

        // Deals with ball physics
        if ball.isActive {
            ball.yspeed += GRAVITY * deltaTime
            if ball.xspeed > 0 {
                ball.xspeed -= 5
            }
            else if ball.xspeed < 0 {
                ball.xspeed += 5
            }

            // Moves ball
            ball.ypos += ball.yspeed * deltaTime
            ball.xpos += ball.xspeed * deltaTime

            // Resets ball to start position
            if (ball.ypos + BALL_SIZE) > SCREEN_HEIGHT {
                ball.xpos = BALL_START_X_POS
                ball.ypos = BALL_START_Y_POS
                ball.xspeed = 0
                ball.yspeed = 0
                ball.isActive = false
            }
            if (ball.xpos - BALL_SIZE) < 0 || (ball.xpos + BALL_SIZE) > SCREEN_WIDTH{
                ball.xspeed *= -1
            }
        }

        


        // Draw
        raylib.BeginDrawing()
            raylib.ClearBackground(raylib.WHITE)

            drawPegs(pegs)
            drawBall(ball)

        raylib.EndDrawing()
    }

    raylib.CloseWindow()
}