package main

import "core:fmt"
import "core:math/rand"
import "core:time"
import "vendor:raylib"

SCREEN_WIDTH :: 800
SCREEN_HEIGHT :: 450

Peg :: struct {
    x: i32,
    y: i32,
}

generatePegs :: proc() -> (pegs: [10]Peg){
    for i in 0..<len(pegs) {
        x := 50 + rand.int31_max(700)
        y := 75 + rand.int31_max(350)

        pegs[i] = Peg{x, y}
    }

    return pegs
}


main :: proc() {
    raylib.InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "Window")
    raylib.SetTargetFPS(30)

    pegs := generatePegs()

    for !raylib.WindowShouldClose() {



        raylib.BeginDrawing()
        raylib.ClearBackground(raylib.WHITE)

        for peg in pegs {
            raylib.DrawCircle(peg.x, peg.y, 5, raylib.BLACK)
        }


        raylib.EndDrawing()
    }

    raylib.CloseWindow()
}