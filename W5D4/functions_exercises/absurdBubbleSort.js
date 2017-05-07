const readline = require('readline');

const reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function askIfGreaterThan(el1, el2, callback){
  reader.question(`Is ${el1} greater than ${el2}? \n`, (answer) => {
    if (answer === "yes"){
      callback(true);
    } else {
      callback(false);
    }
  });
}
// askIfGreaterThan(1, 3, bool=>console.log(bool) );
// Once you're done testing askIfGreaterThan with dummy arguments, write this.
function innerBubbleSortLoop(arr, i, madeAnySwaps, outerBubbleSortLoop) {
  if (i === arr.length - 1) return outerBubbleSortLoop(madeAnySwaps);
  let el1 = arr[i];
  let el2 = arr[i + 1];
  askIfGreaterThan(el1, el2, (isGreaterThan) => {
    if (isGreaterThan) {
      let temp = arr[i + 1];
      arr[i + 1] = arr[i];
      arr[i] = temp;
    }
    let swapped = madeAnySwaps || isGreaterThan;
    innerBubbleSortLoop(arr, i + 1, swapped, outerBubbleSortLoop );
  });
}

// innerBubbleSortLoop([4,3,2,1], 0, false, () => console.log('hi'));

function absurdBubbleSort(arr, sortCompletionCallback) {
  function outerBubbleSortLoop(madeAnySwaps) {
    // Begin an inner loop if you made any swaps. Otherwise, call
    // `sortCompletionCallback`.
    if (madeAnySwaps) {
      innerBubbleSortLoop(arr, 0, false, outerBubbleSortLoop);
    } else {
      sortCompletionCallback(arr);
    }
  }

  // Kick the first outer loop off, starting `madeAnySwaps` as true.
  outerBubbleSortLoop(true);
}

absurdBubbleSort([4, 3, 2, 1], function (arr) {
  console.log("Sorted array: " + JSON.stringify(arr));
  reader.close();
});
