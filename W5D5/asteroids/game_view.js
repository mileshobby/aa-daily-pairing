const Game = require('./game');
const KeyMaster = require('./keymaster');

function GameView(ctx) {
  this.game = new Game();
  this.ctx = ctx;
}

GameView.prototype.start = function () {
  setInterval(() => {
    this.game.step(this.ctx);
    this.bindKeyHandlers();
  }, 20);
};

GameView.prototype.bindKeyHandlers = function () {
  if(KeyMaster.isPressed("up")) this.game.ship.pos[1]-=5;
  if(KeyMaster.isPressed("down")) this.game.ship.pos[1]+=5;
  if(KeyMaster.isPressed("left")) this.game.ship.pos[0]-=5;
  if(KeyMaster.isPressed("right")) this.game.ship.pos[0]+=5;
};

module.exports = GameView;
