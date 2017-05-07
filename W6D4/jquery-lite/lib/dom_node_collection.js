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
