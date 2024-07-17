package game

import rl "vendor:raylib"

main :: proc() {
    rl.InitWindow(1280, 720, "My First Game")
    rl.SetTargetFPS(144)

    backgroundRec := rl.Rectangle{
        x =      0,                  // Rectangle top-left corner position x
        y =      0,                  // Rectangle top-left corner position y
        width =  1280,                  // Rectangle width
        height = 720,                  // Rectangle height
    }

    player1Pos : rl.Vector2 = {100, f32((rl.GetScreenHeight() / 2 ) - 40)}
    player2Pos : rl.Vector2 = {f32(rl.GetScreenWidth() - 100), f32((rl.GetScreenHeight() / 2 ) - 40)}

    for !rl.WindowShouldClose() {
        rl.BeginDrawing()
        rl.ClearBackground(rl.BLACK)
        rl.DrawRectangleGradientEx(backgroundRec, rl.BLACK, rl.Color{253,134,110,255}, rl.BLACK, rl.Color{253,134,110,255})
        rl.DrawFPS(10,10)

        // ball
        rl.DrawRectangle((rl.GetScreenWidth() / 2) - 5, (rl.GetScreenHeight() / 2 ) - 5, 10, 10, rl.WHITE)


        //paddles
        if rl.IsKeyDown(rl.KeyboardKey.W) && player1Pos.y > 0 {
            player1Pos.y -= 500 * rl.GetFrameTime()
        }
        if rl.IsKeyDown(rl.KeyboardKey.S) && player1Pos.y < 720 - 80  {
            player1Pos.y += 500 * rl.GetFrameTime()
        }

        if rl.IsKeyDown(rl.KeyboardKey.UP) && player1Pos.y > 0 {
            player2Pos.y -= 500 * rl.GetFrameTime()
        }
        if rl.IsKeyDown(rl.KeyboardKey.DOWN) && player1Pos.y < 720 - 80  {
            player2Pos.y += 500 * rl.GetFrameTime()
        }

        rl.DrawRectangle(i32(player1Pos.x), i32(player1Pos.y), 10, 80, rl.WHITE)
        rl.DrawRectangle(i32(player2Pos.x), i32(player2Pos.y), 10, 80, rl.WHITE)

        rl.EndDrawing()
    }

    rl.CloseWindow()
}
