function MovingObject(obj) {
  this.pos = obj.pos;
  this.vel = obj.vel;
  this.radius = obj.radius;
  this.color = obj.color;
}

MovingObject.prototype.draw = function (ctx) {
  ctx.beginPath();
  ctx.fillStyle = this.color;
  ctx.arc(this.pos[0], this.pos[1], this.radius, 0, 2*Math.PI);
  ctx.fill();
  ctx.stroke();
  ctx.closePath();
};

MovingObject.prototype.move = function (dim) {
  this.pos[0] = (this.vel[0] + this.pos[0]);
  this.pos[1] = (this.vel[1] + this.pos[1]);
  if(this.pos[0] < -this.radius) this.pos[0] = this.radius + dim;
  if(this.pos[1] < -this.radius) this.pos[1] = this.radius + dim;
  if(this.pos[0] > dim+this.radius) this.pos[0] = -this.radius;
  if(this.pos[1] > dim+this.radius) this.pos[1] = -this.radius;
};

MovingObject.prototype.isCollidedWith = function (otherObject) {
  return (MovingObject.distance(this.pos, otherObject.pos)
    < (this.radius + otherObject.radius));
};

MovingObject.distance = function (pos1, pos2) {
  return Math.sqrt(
    Math.pow(pos1[0]-pos2[0],2) +
    Math.pow(pos1[1]-pos2[1],2)
  );
};

MovingObject.randomPosition = function (dim) {
    const x = Math.floor(Math.random() * dim);
    const y = Math.floor(Math.random() * dim);
    return [x, y];
};

module.exports = MovingObject;
