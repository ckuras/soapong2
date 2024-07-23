package game

import rl "../libs/raylib"

title :: "Soapong 2"
window_width :: 1280
window_height :: 720

Game :: struct {
    backgroundRec: rl.Rectangle,

    ballPos: rl.Vector2,
    ballVel: rl.Vector2,

    player1Pos: rl.Vector2,
    player2Pos: rl.Vector2,

    p1Score: u8,
    p2Score: u8,
}

main :: proc() {
    rl.InitWindow(window_width, window_height, title)
    rl.SetTargetFPS(144)

    game := create()

    for !rl.WindowShouldClose() {
        update(&game);
        draw(&game);
    }
}

create :: proc() -> Game {
    game := Game {}

    game.backgroundRec = {
        x =      0,    // Rectangle top-left corner position x
        y =      0,    // Rectangle top-left corner position y
        width =  1280, // Rectangle width
        height = 720,  // Rectangle height
    }

    game.ballPos = {f32((rl.GetScreenWidth() / 2) - 5), f32((rl.GetScreenHeight() / 2 ) - 5)}
    game.ballVel = {-300,0}

    game.player1Pos = {100, f32((rl.GetScreenHeight() / 2 ) - 40)}
    game.player2Pos = {f32(rl.GetScreenWidth() - 100), f32((rl.GetScreenHeight() / 2 ) - 40)}

    game.p1Score = 0
    game.p2Score = 0

    return game
}

update :: proc(using game: ^Game) {
    // paddles
    if rl.IsKeyDown(rl.KeyboardKey.W) && game.player1Pos.y > 0 {
        game.player1Pos.y -= 500 * rl.GetFrameTime()
    }
    if rl.IsKeyDown(rl.KeyboardKey.S) && game.player1Pos.y < 720 - 80  {
        game.player1Pos.y += 500 * rl.GetFrameTime()
    }

    if rl.IsKeyDown(rl.KeyboardKey.UP) && game.player2Pos.y > 0 {
        game.player2Pos.y -= 500 * rl.GetFrameTime()
    }
    if rl.IsKeyDown(rl.KeyboardKey.DOWN) && game.player2Pos.y < 720 - 80  {
        game.player2Pos.y += 500 * rl.GetFrameTime()
    }

    ballRec : rl.Rectangle = {
        game.ballPos.x,
        game.ballPos.y,
        10,
        10,
    }

    player1Rec : rl.Rectangle = {
        game.player1Pos.x,
        game.player1Pos.y,
        10,
        80,
    }
    player2Rec : rl.Rectangle = {
        game.player2Pos.x,
        game.player2Pos.y,
        10,
        80,
    }

    if rl.CheckCollisionRecs(ballRec, player1Rec) {
        diffToPaddleCenter := (player1Pos.y + 40) - (ballPos.y + 5)
        game.ballVel.x *= -1
        game.ballVel.y = diffToPaddleCenter * -5
    }
    
    if rl.CheckCollisionRecs(ballRec, player2Rec) {
        diffToPaddleCenter := (player2Pos.y + 40) - (ballPos.y + 5)
        game.ballVel.x *= -1
        game.ballVel.y = diffToPaddleCenter * -5
    }

    if game.ballPos.y <= 0 {
        game.ballVel.y *= -1
    }
    if game.ballPos.y >= f32(rl.GetScreenHeight() - 10){
        game.ballVel.y *= -1
    }

    if game.ballPos.x >= f32(rl.GetScreenWidth()) {
        game.p1Score += 1
        game.ballPos = {f32((rl.GetScreenWidth() / 2) - 5), f32((rl.GetScreenHeight() / 2 ) - 5)}
        game.ballVel = {300,0}
    }
    if game.ballPos.x <= 0 {
        game.p2Score += 1
        game.ballPos = {f32((rl.GetScreenWidth() / 2) - 5), f32((rl.GetScreenHeight() / 2 ) - 5)}
        game.ballVel = {-300,0}
    }

    // ball
    ballPos.x += ballVel.x * rl.GetFrameTime()
    ballPos.y += ballVel.y * rl.GetFrameTime()
}

draw :: proc(using game: ^Game) {
    rl.BeginDrawing()
    defer rl.EndDrawing()
    
    rl.ClearBackground(rl.BLACK)
    rl.DrawRectangleGradientEx(backgroundRec, rl.BLACK, rl.Color{253,134,110,255}, rl.BLACK, rl.Color{253,134,110,255})
    rl.DrawFPS(10,10)

    rl.DrawRectangle(i32(ballPos.x), i32(ballPos.y), 10, 10, rl.WHITE)
    rl.DrawRectangle(i32(player1Pos.x), i32(player1Pos.y), 10, 80, rl.WHITE)
    rl.DrawRectangle(i32(player2Pos.x), i32(player2Pos.y), 10, 80, rl.WHITE)

    // ui
    score := rl.TextFormat("%d : %d", p1Score, p2Score)
    rl.DrawText(rl.TextFormat("%d : %d", p1Score, p2Score), (rl.GetScreenWidth() / 2) - (rl.MeasureText(score, 32) / 2), 40, 32, rl.WHITE)
}