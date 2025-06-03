# Week 11 – Advanced Brick Breaker

This sketch expands on the classic brick breaker game by adding multiple levels, sound effects, power-ups, and visual polish. It builds on foundational game logic to explore more advanced interaction design and gameplay pacing.


Requirements

- Written in **Processing 4.3** or higher
- No external libraries required (all audio and graphics handled natively)

---

▶️ Operation

1. Open the `AdvancedBrickBreaker.pde` sketch in Processing.
2. Click **Run** or press `Ctrl + R` / `Cmd + R` to start the game.
3. Use the **left** and **right arrow keys** to move the paddle.
4. Press **spacebar** to launch the ball.
5. Press **P** to pause/resume. Press **R** to restart at any time.

Features

- 🧱 Multiple levels with different brick layouts
- ⚡ Power-ups such as:
  - Wide Paddle
  - Extra Ball
  - Slow Motion
- 💥 Bricks with different strengths (require 1–3 hits to destroy)
- 🔊 Sound effects triggered on collisions and events
- 💡 Particle effects on brick destruction
- 🔄 Level transitions with visual feedback
- 📈 Score and high score tracking



Screengrab
![image](https://github.com/user-attachments/assets/fd17d24a-c59c-422f-9aa2-76591076ac34)



Design Notes

This version focuses on enhancing engagement through reactive visuals and richer feedback systems. Key design challenges included:

- Managing multiple game states (start, playing, paused, win/lose)
- Introducing randomness without breaking game balance
- Designing modular classes for bricks, ball, paddle, and power-ups
- Ensuring fluid performance while rendering many objects and effects

The project blends **game mechanics, visual design, and basic audio design**, and can serve as a strong base for further development into a complete arcade-style game.

Possible Improvements

- Add background music
- Implement level editor or load from external files
- Create mobile controls (for Android export)
- Add visual themes (space, cyberpunk, underwater, etc.)
