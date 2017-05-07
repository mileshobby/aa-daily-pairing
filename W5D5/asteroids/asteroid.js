const MovingObject = require("./moving_object");
const Util = require("./utils");

function Asteroid(pos) {
  let params = {};
  params.pos = pos;
  params.vel = Asteroid.random_vel();
  params.color = "#7A8B7F";
  params.radius = Asteroid.random_radius();
  MovingObject.call(this, params);
}

Util.inherits(Asteroid, MovingObject);

Asteroid.random_vel = function() {
  const dx = (Math.floor(Math.random() * 10)-5);
  const dy = (Math.floor(Math.random() * 10)-5);
  return [dx, dy];
};

Asteroid.random_radius = function() {
  return Math.floor((Math.random() * 20) + 20);
};

module.exports = Asteroid;
