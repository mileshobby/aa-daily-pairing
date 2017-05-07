import React from "react";

class Tab extends React.Component{
  constructor({windows}){
    super();
    this.windows = windows;
    this.state = {selectedTab: 0};
    this.changeTab = this.changeTab.bind(this);
  }

  changeTab(num,e){
    this.setState({selectedTab: num});
  }

  render(){
    return (
      <div id="tab">
        <ul>
          <li onClick={this.changeTab.bind(null, 0)}>{this.windows[0].title}</li>
          <li onClick={this.changeTab.bind(null, 1)}>{this.windows[1].title}</li>
          <li onClick={this.changeTab.bind(null, 2)}>{this.windows[2].title}</li>
        </ul>
        <div className="small">
          <section >
            {this.windows[this.state.selectedTab].content}
          </section>
        </div>
      </div>
    );
  }
}

export default Tab;
