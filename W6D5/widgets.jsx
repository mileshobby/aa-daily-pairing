import React from 'react';
import ReactDOM from 'react-dom';
import Clock from './frontend/clock';
import Weather from './frontend/weather';
import AutoComplete from './frontend/autocomplete';

const NAMES = ['miles', 'hobby', 'yong', 'lin', 'sean', 'perfecto'];

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
        <AutoComplete names={NAMES} />
      </div>
    );
  }

}
