const readline = require('readline');
const reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

class Game {
  constructor() {
    this.stacks = [[1, 2, 3], [], []];
  }

  run(completionCallback) {
    this.promptMove(this.move.bind(this), completionCallback);
  }

  nextRound(completionCallback) {
    if (this.isWon()) {
      return completionCallback();
    } else {
      return this.run(completionCallback);
    }
  }

  promptMove(cb, completionCallback) {
    console.log(this.stacks);
    reader.question("where yo wanna take from? \n>", (startTowerIdx) => {
      reader.question("where you tryna go? \n>", (endTowerIndx) => {
        cb(startTowerIdx, endTowerIndx);
        this.nextRound(completionCallback);
      });
    });
  }

  isValidMove(startTowerIdx, endTowerIndx){
    return (this.stacks[startTowerIdx].length > 0 &&
            (this.stacks[endTowerIndx].length === 0 ||
            this.stacks[startTowerIdx][0] < this.stacks[endTowerIndx][0])
          );
  }

  move(startTowerIdx, endTowerIndx){
    if (this.isValidMove(startTowerIdx, endTowerIndx)){
      let disc = this.stacks[startTowerIdx].shift();
      this.stacks[endTowerIndx].unshift(disc);
    } else {
      console.log("Invalid move");
    }
  }

  print() {
    return JSON.stringify(this.stacks);
  }

  isWon() {
    return (this.stacks[1].length === 3 || this.stacks[2].length === 3);
  }
}

module.exports = Game;
