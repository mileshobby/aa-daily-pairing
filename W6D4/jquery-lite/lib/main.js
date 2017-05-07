const DOMNodeCollection = require('./dom_node_collection');

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
