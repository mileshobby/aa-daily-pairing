class Board {
  constructor(grid) {
    this.grid = grid;
  }

  emptyBoard() {
    return new Array(3).fill().map(() => new Array(3).fill());
  }

  render() {
    console.log('--------');
    this.grid.forEach((row) => {
      console.log(row.join(' | '));
      console.log('--------');
    });
  }

  isWon() {
    let possibilities = this.rows().concat(this.diagonals(), this.columns());
    for(let i = 0; i < possibilities.length; i++){
      let cp = possibilities[i];
      let mark = cp[0];
      if (mark === undefined) continue;
      let won = true;
      for(let j = 1; j < cp.length; j++){
        if (cp[j] !== mark){
            won = false;
            break;
        }
      }
      if (won) return mark;
    }
    return false;
  }

  isEmpty(pos) {
    const row = pos[0];
    const col = pos[1];
    return this.grid[row][col] === undefined;
  }

  columns() {
    let transposed = new Array(3).fill().map(()=> new Array(3).fill());
    for(let i = 0; i < transposed.length; i++){
      for(let j = 0; j < transposed.length; j++){
        transposed[i][j] = this.grid[j][i];
      }
    }
    return transposed;
  }

  diagonals() {
    return [ [this.grid[0][0],this.grid[1][1], this.grid[2][2]],
             [this.grid[0][2],this.grid[1][1], this.grid[2][0]] ];
  }

  rows() {
    return this.grid;
  }

}

// const b = new Board(new Array(3).fill().map(() => new Array(3).fill('x')));
// b.render();
// console.log(b.isWon());
