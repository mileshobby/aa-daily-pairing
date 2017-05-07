Array.prototype.twoSum = function () {
  let indices = [];
  for(let i = 0; i < this.length - 1; i++ ){
    for(let j = i + 1; j < this.length; j++){
      if (this[i] + this[j] === 0){
        indices.push([i,j]);
      }
    }
  }
  return indices;
};

// console.log([1,2,3,-2, -1].twoSum());

Array.prototype.uniq = function () {
  let arr = [];
  for(let i = 0; i < this.length; i++){
    if (arr.includes(this[i])){
      continue;
    } else{
      arr.push(this[i]);
    }
  }
  return arr;
};
// console.log([1,2,3,-2, 3, -2, -1].uniq());

Array.prototype.transpose = function () {

  let transposed = new Array(this.length).fill();
  transposed = transposed.map( (el) => {
    return new Array(this.length);
  });

  for (let i = 0; i < this.length; i++) {
    for (let j = 0; j < this.length; j++) {
      transposed[i][j] = this[j][i];
    }
  }


  return transposed;
};

// console.log([[3,4,5],[6,7,8],[9,10,11]].transpose());
Array.prototype.myEach = function(cb) {
  for (let i = 0; i < this.length; i++){
    console.log("i'm stuck!");
    cb(this[i]);
  }
  return this;
};


// (callback) => {
//   console.log(this)
//   for (let i = 0; i < this.length; i++){
//     console.log("i'm stuck!");
//     callback(this[i]);
//   }
//   return this;
// };

// [1,2,3,4,5].myEach( (el) => {
//   console.log(el*2);
// });

Array.prototype.myMap = function(cb) {
  let mapped = [];
  this.myEach( (el) => {
    mapped.push(cb(el));
  });
  return mapped;
};

// console.log([3,4,5].myMap( function(el) {
//   return el + 2;
// }));

Array.prototype.myInject = function(cb) {
  let sum = this[0];
  let arr = this.slice(1);
  arr.myEach ( (el) => {
    sum = cb(sum, el);
  });
  return sum;
};

// console.log([1,2,3,4,5].myInject( function(sum,el) {
//   return sum+el;
// }));

const bubbleSort = function(arr) {
  let sorted = false;
  while (sorted === false){
    sorted = true;
    for (let i = 0; i < arr.length; i++){
      if (arr[i] > arr[i+1]){
        sorted = false;
        let temp = arr[i];
        arr[i] = arr[i+1];
        arr[i+1] = temp;
      }
    }
  }
  return arr;
};

// console.log(bubbleSort([5,1,3,8,2]));

String.prototype.substrings = function() {
  let subs = [];
  for(let i = 0; i < this.length; i++) {
    for(let j = i; j < this.length; j++) {
      let sub = this.slice(i, j+1);
      if (!subs.includes(sub)) {
        subs.push(sub);
      }
    }
  }
  return subs;
};

// console.log("cat".substrings());

const range = function(start,end) {
  if (end < start) {
    return [];
  }
  return [start].concat( range(start + 1, end));
};

// console.log(range(3,6));

const exp = function(base, pow) {
  if (pow === 0) return 1;
  return base * exp(base, pow - 1);
};

// console.log(exp(3,4));

function rec_fib(n){
  if (n === 1) return [0];
  if (n === 2) return [0, 1];
  let this_fib = rec_fib(n-1);
  this_fib.push(this_fib[this_fib.length-2] + this_fib[this_fib.length-1]);
  return this_fib;
}
// console.log(rec_fib(4));

function it_fib(n) {
  if (n === 1) return [0];
  if (n === 2) return [0,1];
  let arr = [0,1];
  while (arr.length < n) {
    arr.push(arr[arr.length-2] + arr[arr.length-1]);
  }
  return arr;
}
// console.log(it_fib(4));

function bsearch(array, target){
  if (array.length === 0 ) return null;
  let mid = Math.floor(array.length/2);
  if (array[mid] === target) return mid;
  if (array[mid] > target){
    let left = array.slice(0, mid);
    return bsearch(left, target);
  } else {
    let right = array.slice(mid + 1);
    return bsearch(right, target) + mid + 1;
  }
}

// console.log(bsearch([1,2,3,4,5], 5));

// function makeChange(amount, array) {
//   if (amount === 0) return [];
//   let change = [];
//   let biggestCoin = array[0];
//   if (amount >= biggestCoin) {
//     amount -= biggestCoin;
//     change.push(biggestCoin);
//     return change.concat(makeChange(amount, array));
//   }
//   return change.concat(makeChange(amount, array.slice(1)));
// }

// console.log(makeChange(14, [10, 7, 1]));

function makeBetterChange(amount, array) {
  if (amount === 0) return [];
  // let biggestCoin = array[0];
  // let temp = makeBetterChange();
  let i = 0;
  let bestResult = null;
  array.forEach( (coin) => {
    let thisAmount = amount;
    if (thisAmount >= coin) {
        thisAmount -= coin;
        let change = makeBetterChange(thisAmount, array.slice(i));
        let thisResult = [coin].concat(change);
        if (bestResult === null || thisResult.length < bestResult.length){
          bestResult = thisResult;
        }
    }
    i++;
  });
  return bestResult;
}
// console.log(makeBetterChange(14, [10, 7, 1]));

function mergeSort(array) {
  if (array.length <= 1) return array;
  let mid = Math.floor(array.length/2);
  let left = mergeSort(array.slice(0, mid));
  let right = mergeSort(array.slice(mid, array.length));
  return merge(left, right);
}

function merge(left, right) {
  let merged = [];
  while (left.length > 0 && right.length > 0){
    if (left[0] < right[0]){
      merged.push(left.shift());
    } else {
      merged.push(right.shift());
    }
  }
  return merged.concat(left).concat(right);
}

console.log(mergeSort([1,5,3,1,5,6]));


function Cat(name, owner) {
  this.name = name;
  this.owner = owner;
}

Cat.prototype.cuteStatement = function() {
  return `${this.owner} loves ${this.name}.`;
};


const Joe = new Cat("Joe", "Thermos");
const Apple = new Cat ("Apple", "Sauce");

Cat.prototype.cuteStatement = function() {
  return `Everyone loves ${this.name}`;
};

// console.log(Joe.cuteStatement());

Cat.prototype.meow = function() {
  return `${this.name} says meow`;
};

Apple.meow = function() {
  return `${Apple.name} doesn't say meow`;
};

// console.log(Joe.meow());
// console.log(Apple.meow());
