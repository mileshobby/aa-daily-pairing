const Game = require ("./game.js");

const readline1 = require('readline');
const reader1 = readline1.createInterface({
  input: process.stdin,
  output: process.stdout
});


function play(){
  const game = new Game;
  game.run( () => {
    console.log('yay');
    reader1.question("would you like to play again?", (answer) => {
      if (answer === "yes"){
        play();
      } else{
        console.log('youre done.');
        reader1.close();
        return;
      }
    });

  });

}

play();
