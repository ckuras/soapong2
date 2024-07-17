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

    ballPos : rl.Vector2 = {f32((rl.GetScreenWidth() / 2) - 5), f32((rl.GetScreenHeight() / 2 ) - 5)}
    ballVel : rl.Vector2 = {-300,0}

    player1Pos : rl.Vector2 = {100, f32((rl.GetScreenHeight() / 2 ) - 40)}
    player2Pos : rl.Vector2 = {f32(rl.GetScreenWidth() - 100), f32((rl.GetScreenHeight() / 2 ) - 40)}

    p1Score := 0
    p2Score := 0

    for !rl.WindowShouldClose() {
        rl.BeginDrawing()
        rl.ClearBackground(rl.BLACK)
        rl.DrawRectangleGradientEx(backgroundRec, rl.BLACK, rl.Color{253,134,110,255}, rl.BLACK, rl.Color{253,134,110,255})
        rl.DrawFPS(10,10)

        // ui
        score := rl.TextFormat("%d : %d", p1Score, p2Score)
        rl.DrawText(rl.TextFormat("%d : %d", p1Score, p2Score), (rl.GetScreenWidth() / 2) - (rl.MeasureText(score, 32) / 2), 40, 32, rl.WHITE)

        // ball
        ballPos.x += ballVel.x * rl.GetFrameTime()
        ballPos.y += ballVel.y * rl.GetFrameTime()

        rl.DrawRectangle(i32(ballPos.x), i32(ballPos.y), 10, 10, rl.WHITE)

        //paddles
        if rl.IsKeyDown(rl.KeyboardKey.W) && player1Pos.y > 0 {
            player1Pos.y -= 500 * rl.GetFrameTime()
        }
        if rl.IsKeyDown(rl.KeyboardKey.S) && player1Pos.y < 720 - 80  {
            player1Pos.y += 500 * rl.GetFrameTime()
        }

        if rl.IsKeyDown(rl.KeyboardKey.UP) && player2Pos.y > 0 {
            player2Pos.y -= 500 * rl.GetFrameTime()
        }
        if rl.IsKeyDown(rl.KeyboardKey.DOWN) && player2Pos.y < 720 - 80  {
            player2Pos.y += 500 * rl.GetFrameTime()
        }

        rl.DrawRectangle(i32(player1Pos.x), i32(player1Pos.y), 10, 80, rl.WHITE)
        rl.DrawRectangle(i32(player2Pos.x), i32(player2Pos.y), 10, 80, rl.WHITE)

        ballRec : rl.Rectangle = {
            ballPos.x,
            ballPos.y,
            10,
            10,
        }

        player1Rec : rl.Rectangle = {
            player1Pos.x,
            player1Pos.y,
            10,
            80,
        }
        player2Rec : rl.Rectangle = {
            player2Pos.x,
            player2Pos.y,
            10,
            80,
        }

        if rl.CheckCollisionRecs(ballRec, player1Rec) {
            diffToPaddleCenter := (player1Pos.y + 40) - (ballPos.y + 5)
            ballVel.x *= -1
            ballVel.y = diffToPaddleCenter * -5
        }
        
        if rl.CheckCollisionRecs(ballRec, player2Rec) {
            diffToPaddleCenter := (player2Pos.y + 40) - (ballPos.y + 5)
            ballVel.x *= -1
            ballVel.y = diffToPaddleCenter * -5
        }

        if ballPos.y <= 0 {
            ballVel.y *= -1
        }
        if ballPos.y >= f32(rl.GetScreenHeight() - 10){
            ballVel.y *= -1
        }

        if ballPos.x >= f32(rl.GetScreenWidth()) {
            p1Score += 1
            ballPos = {f32((rl.GetScreenWidth() / 2) - 5), f32((rl.GetScreenHeight() / 2 ) - 5)}
            ballVel = {300,0}
        }
        if ballPos.x <= 0 {
            p2Score += 1
            ballPos = {f32((rl.GetScreenWidth() / 2) - 5), f32((rl.GetScreenHeight() / 2 ) - 5)}
            ballVel = {-300,0}
        }

        rl.EndDrawing()
    }

    rl.CloseWindow()
}
