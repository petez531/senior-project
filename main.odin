package main

import "core:fmt"
import "vendor:raylib"

SCREEN_WIDTH :: 800
SCREEN_HEIGHT :: 450



main :: proc() {
    raylib.InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "Window")
    raylib.SetTargetFPS(30)


    for !raylib.WindowShouldClose() {
        
        raylib.BeginDrawing()

        raylib.ClearBackground(raylib.RAYWHITE)

        raylib.DrawText("WINDOW!!!", 190, 200, 20, raylib.LIGHTGRAY)


        raylib.EndDrawing()


    }

    raylib.CloseWindow()
}