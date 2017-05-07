const GameView = require('./game_view');

document.addEventListener("DOMContentLoaded", function(event) {
  const canvasEl = document.getElementById("game-canvas");
  canvasEl.width = 700;
  canvasEl.height = 700;

  const ctx = canvasEl.getContext("2d");

  const g = new GameView(ctx);
  g.start();
});
