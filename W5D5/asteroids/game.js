const Asteroid = require('./asteroid');
const Ship = require('./ship');
const MovingObject = require('./moving_object');

function Game() {
  this.asteroids = new Array;
  this.addAsteroids();
  this.ship = new Ship();
}

Game.DIM_X = 700;
Game.DIM_Y = 700;
Game.NUM_ASTEROIDS = 10;

Game.prototype.addAsteroids = function () {
  if (this.asteroids.length < Game.NUM_ASTEROIDS) {
    const asteroid = new Asteroid(MovingObject.randomPosition(Game.DIM_X));
    this.asteroids.push(asteroid);
    this.addAsteroids();
  }
};

Game.prototype.allObjects = function(){
  return this.asteroids.concat([this.ship]);
};

Game.prototype.draw = function (ctx) {
  ctx.clearRect(0, 0, Game.DIM_X, Game.DIM_Y);
  ctx.fillStyle = "black";
  ctx.fillRect(0, 0, 700, 700);
  const objs = this.allObjects();
  for (let i = 0; i < objs.length; i++) {
    objs[i].draw(ctx);
  }
};

Game.prototype.moveObjects = function () {
  for (let i = 0; i < this.asteroids.length; i++) {
    this.asteroids[i].move(Game.DIM_X);
  }
  this.ship.move(Game.DIM_X);
};

Game.prototype.checkCollisions = function () {
  for (let i = 0; i < this.asteroids.length; i++) {
    if (this.asteroids[i].isCollidedWith(this.ship)) {
      this.ship.relocate(Game.DIM_X);
    }
  }
};

Game.prototype.remove = function (i) {
  this.asteroids.splice(i, 1);
};

Game.prototype.step = function (ctx) {
  this.moveObjects();
  this.checkCollisions();
  this.draw(ctx);
  // this.ship.pos[0] = //Math.floor(this.ship.vel[0] / 1.1);
  // this.ship.pos[1] = //Math.floor(this.ship.vel[1] / 1.1);
};



module.exports = Game;
