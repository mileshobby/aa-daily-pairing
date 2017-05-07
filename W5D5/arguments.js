// function sum(){
//   let s = 0;
//   for (let i = 0; i < arguments.length; i++) {
//     s += arguments[i];
//   }
//   return s;
// }
// function sum2(...args){
//   let s = 0;
//   for (let i = 0; i < args.length; i++) {
//     s += args[i];
//   }
//   return s;
// }
//
// // console.log(sum(1,2,3,4));
// // console.log(sum2(1,2,3,4));
//
// Function.prototype.myBind = function (context){
//   let args = Array.from(arguments).slice(1);
//   let func = this;
//   return function() {
//     let arg2 = Array.from(arguments);
//     func.call(context, ...args, ...arg2);
//   };
// };
//
// Function.prototype.myBind2 = function (context, ...args){
//   let func = this;
//   return function(...arg2) {
//     func.call(context, ...args, ...arg2);
//   };
// };

// class Cat {
//   constructor(name) {
//     this.name = name;
//   }
//
//   says(sound, person) {
//     console.log(`${this.name} says ${sound} to ${person}!`);
//     return true;
//   }
// }
//
// const markov = new Cat("Markov");
// const breakfast = new Cat("Breakfast");
//
// markov.says("meow", "Ned");
// // Markov says meow to Ned!
// // true
//
// // bind time args are "meow" and "Kush", no call time args
// markov.says.myBind2(breakfast, "meow", "Kush")();
// // Breakfast says meow to Kush!
// // true
//
// // no bind time args (other than context), call time args are "meow" and "me"
// markov.says.myBind2(breakfast)("meow", "a tree");
// // Breakfast says meow to a tree!
// // true
//
// // bind time arg is "meow", call time arg is "Markov"
// markov.says.myBind2(breakfast, "meow")("Markov");
// // Breakfast says meow to Markov!
// // true
//
// // no bind time args (other than context), call time args are "meow" and "me"
// const notMarkovSays = markov.says.myBind2(breakfast);
// notMarkovSays("meow", "me");
// // Breakfast says meow to me!
// // true
//
// function curriedSum(numArgs){
//   let numbers = [];
//   const _curriedSum = (num) => {
//     numbers.push(num);
//     if (numbers.length === numArgs) {
//       return numbers.reduce(add, 0);
//     }
//     else {
//       return _curriedSum;
//     }
//   };
//   return _curriedSum;
// }
//
// function add(a, b) {
//     return a + b;
// }
//
// const sum = curriedSum(4);
// const sum2 = curriedSum(5);
// sum2(20);
// console.log(sum(5)(30)(20)(1));



function sumThree(num1, num2, num3) {
  return num1 + num2 + num3;
}

Function.prototype.curry = function(numArgs) {
  let args = [];
  const _curry = (arg) => {
    args.push(arg);
    if (args.length === numArgs) {
      return this.call(this, ...args);
    }
    else {
      return _curry;
    }
  };

  return _curry;
};

let f1 = sumThree.curry(3); // tells `f1` to wait until 3 arguments are given before running `sumThree`
f1 = f1(4); // [Function]
f1 = f1(20); // [Function]
console.log(f1(6)); // = 30

// or more briefly:
console.log(sumThree.curry(3)(4)(20)(6)); // == 30
