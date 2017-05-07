class View {

  constructor(game, rootEl){
    this.game = game;
    window.game = game;
    this.rootEl = rootEl;
    this.setupTowers();
    this.fromMove = null;
    this.toMove = null;
    this.rootEl.click((e)=>{
      this.clickTower(e);
    });
  }

  setupTowers(){
    for (let i = 0; i < 3; i++) {
      this.rootEl.append($(`<ul data-idx=${i}></ul>`));
    }
    const $ul1 = $('ul').first();
    let $li;
    for (let i = 1; i < 4; i++) {
      $li = $("<li>");
      $li.attr('id', `disc${i}`);
      $ul1.append($li);
    }
  }

  render() {
    console.log(this.fromMove);
    let $fromStack = $('<ul>').eq(this.fromMove);
    console.log($fromStack);
    let $toStack = $('<ul>').eq(this.toMove);
    let $disc = $fromStack.children("li:first");
    console.log($disc);
    $disc.remove();
    console.log($disc);
    $toStack.prepend($disc);
  }

  clickTower(e) {
    let $stack = $(e.target);
    let idx = $stack.data("idx");
    if (this.fromMove === null){
      this.fromMove = idx;
    }
    else{
      this.toMove = idx;
      this.game.move(this.fromMove, this.toMove);
      // console.log(this.fromMove);
      // console.log(this.toMove);
      this.render();
      this.fromMove = null;
      this.toMove = null;
    }
  }

}

module.exports = View;
