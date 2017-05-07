/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId])
/******/ 			return installedModules[moduleId].exports;
/******/
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// identity function for calling harmony imports with the correct context
/******/ 	__webpack_require__.i = function(value) { return value; };
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, {
/******/ 				configurable: false,
/******/ 				enumerable: true,
/******/ 				get: getter
/******/ 			});
/******/ 		}
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ (function(module, exports, __webpack_require__) {

const DOMNodeCollection = __webpack_require__(1);

let queue = [];

window.$l = function(arg){
  let elements;
  if(typeof arg === 'string'){
    let elementList = document.querySelectorAll(arg);
    elements =  Array.from(elementList);
  } else if (arg instanceof HTMLElement) {
    elements = [arg];
  } else {
    queue.push(arg);
    return;
  }
  return new DOMNodeCollection(elements);
};

window.$l.extend = function (...objs){
  let merged = objs[0];
  for (let i = 1; i < objs.length; i++) {
    let keys = Object.keys(objs[i]);
    keys.forEach(key=>{
      merged[key] = objs[i][key];
    });
  }
  return merged;
};
//type, url, success, error, data, datatype
window.$l.ajax = function(options){
  let defaults = {
    type: 'GET',
    url: './',
    datatype: 'json',
    data: {},
    success: () => {},
    error: () => {}
  };
  // console.log(defaults);
  // console.log(options);
  window.$l.extend(defaults, options);
  console.log(options);
  console.log(defaults);
  const xhr = new XMLHttpRequest();

  // step 2 - specify path and verb
  xhr.open(defaults.type, defaults.url);

  // step 3 - register a callback
  xhr.onload = function () {
    let data = {
      status: xhr.status,
      responseType: xhr.responseType,
      response: xhr.response
    };
    defaults.success(data);
  };

  // step 4 - send off the request with optional data
  xhr.send(defaults.data);
};


document.addEventListener("DOMContentLoaded", function(e) {
  for (var i = 0; i < queue.length; i++) {
    queue[i]();
  }
});


window.$toggleGreen = function(e){
    e.target.classList.add("green");
};


/***/ }),
/* 1 */
/***/ (function(module, exports) {

class DOMNodeCollection {
  constructor (elements) {
    this.elements = elements;
    this.empty = this.empty.bind(this);
  }

  html (string){
    if(string){
      this.elements.forEach((el) => {
        el.innerHTML = string;
      });
    }
    else{
      return this.elements[0].innerHTML;
    }
  }

  empty(){
    this.elements.forEach((el) => {
      el.innerHTML = "";
    });
  }

  append(something){
    this.elements.forEach( (el) => {
      if (typeof something === "string") {
        el.innerHTML += something;
      } else if (something instanceof HTMLElement) {
        el.innerHTML += something.outerHTML;
      } else {
        for (var i = 0; i < something.elements.length; i++) {
          el.innerHTML += something.elements[i].outerHTML;
        }
      }
    });
  }

  attr(attributeName, value){
    if (value) {
      this.elements.forEach((el) => {
        el[attributeName] = value;
    });
    } else {
      return this.elements[0][attributeName];
    }
  }

  addClass(newClass){
    this.elements.forEach((el) => {
      el.setAttribute("class", newClass);
    });
  }

  removeClass(oldClass){
    this.elements.forEach((el) => {
      el.classList.remove(oldClass);
    });
  }

  children(){
    let kids = [];
    this.elements.forEach((el) => {
      kids = kids.concat(el.children);
    });
    return new DOMNodeCollection(kids);
  }

  parent(){
    let parents = [];
    this.elements.forEach((el) => {
      if (!parents.includes(el.parentNode)) {
        parents.push(el.parentNode);
      }
    });
    return new DOMNodeCollection(parents);
  }

  find(selector){
    let found = [];
    this.elements.forEach((el) => {
      found = found.concat(el.querySelectorAll(selector));
    });
    return new DOMNodeCollection(found);
  }

  remove(){
    this.empty();
    this.elements.forEach((el) => {
      el.parentNode.removeChild(el);
    });
  }

  on(ev, callback){
    this.elements.forEach((el) => {
      el.addEventListener(ev, callback);
      el.cb =  callback;
    });
  }

  off(ev){
    this.elements.forEach((el) => {
      console.log(el.cb);
      el.removeEventListener(ev, el.cb);
    });
  }
}

module.exports = DOMNodeCollection;


/***/ })
/******/ ]);