const readline = require('readline');

const reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function addNumbers(sum, numsLeft, completionCallback) {
  if (numsLeft <= 0) {
    completionCallback(sum);
    reader.close();
    return;
  }
  reader.question("Input a number: ", (answer) => {
    let newSum = sum + parseInt(answer);
    console.log(newSum);
    addNumbers(newSum, numsLeft - 1, completionCallback);
  });
}

addNumbers(0, 3, sum => console.log(`Total Sum: ${sum}`));
