import React from 'react';
import ReactDOM from 'react-dom';
import Clock from './frontend/clock';
import Weather from './frontend/weather';
import AutoComplete from './frontend/autocomplete';
import Tab from './frontend/tabs';

const NAMES = ['miles', 'hobby', 'yong', 'lin', 'sean', 'perfecto', 'moopy'];
const WINDOWS = [{title: "tab1", content: "Tab1 is cool"},
                {title: "tab2", content: "Tab1 is cooler"},
                {title: "tab3", content: "Tab1 is the coolest"}];


document.addEventListener("DOMContentLoaded", () => {
  const root = document.getElementById("root");
  ReactDOM.render(<Root />, root);
});

class Root extends React.Component{
  render(){
    return(
      <div>
        <Clock />
        <Weather />
        <div className="row">
          <AutoComplete names={NAMES} />
          <Tab windows={WINDOWS} />
        </div>
      </div>
    );
  }

}
