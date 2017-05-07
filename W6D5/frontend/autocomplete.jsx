import React from 'react';

class AutoComplete extends React.Component {
  constructor({names}) {
    super();
    this.names = names;
    this.state = {matchedNames: names, inputVal: ""};
    this.findNames = this.findNames.bind(this);
    this.nameList = this.nameList.bind(this);
    this.complete = this.complete.bind(this);
  }

  findNames(e){
    let input = e.target.value;
    let matched;
    if (input === "") {
      matched = this.names;
    } else {
      matched = this.names.filter((name)=>name.startsWith(input));
    }
    this.setState({matchedNames: matched});
  }

  nameList(){
    return this.state.matchedNames.map((name, i)=>{
      return <li onClick={this.complete} key={name}>{name}</li>;
    });
  }

  complete(e){
    this.setState({inputVal: e.target.innerHTML});
    const input = document.getElementById("input");
    input.value = e.target.innerHTML;
  }

  render(){
    return (
      <div className="widget" id="autocomplete">
        <h1>Autocomplete</h1>
        <input id="input" type="text" onChange={this.findNames} placeholder='Search...'></input>
        <ul>
          {this.nameList()}
        </ul>
      </div>
    );
  }
}

export default AutoComplete;
