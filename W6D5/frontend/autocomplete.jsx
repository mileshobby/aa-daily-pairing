import React from 'react';

class AutoComplete extends React.Component {
  constructor({names}) {
    super();
    this.names = names;
    this.state = {inputVal: ""};
    this.findNames = this.findNames.bind(this);
    this.handleInput = this.handleInput.bind(this);
    this.complete = this.complete.bind(this);
  }

  findNames(){
    let input = this.state.inputVal;

    let matched;
    if (input === "") {
      matched = this.names;
    } else {
      matched = this.names.filter((name)=>name.startsWith(input));
    }
    return matched;
  }

  handleInput(e){
    this.setState({inputVal: e.target.value});
  }

  complete(e){
    this.setState({inputVal: e.target.innerHTML});
  }

  render(){
    const matches = this.findNames().map(
          (name)=>(<li onClick={this.complete} key={name}>{name}</li>));
    return (
      <div className="widget small" id="autocomplete">
        <h1>Autocomplete</h1>
        <input id="input" type="text" onChange={this.handleInput} value={this.state.inputVal} placeholder='Search...'></input>
        <ul>
          {matches}
        </ul>
      </div>
    );
  }
}

export default AutoComplete;
