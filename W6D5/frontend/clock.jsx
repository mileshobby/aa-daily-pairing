import React from 'react';

class Clock extends React.Component {
  constructor() {
    super();
    let date = new Date();
    this.state = {hours: date.getHours(), minutes: date.getMinutes(),
                  seconds: date.getSeconds(), day: date.getDate(),
                  month: date.getMonth(), year: date.getFullYear()};
    this.tick = this.tick.bind(this);
  }

  tick(){
    let {seconds, minutes, hours} = this.state;

    seconds++;
    if (seconds===60) {
      minutes++;
      seconds = 0;
      if (minutes === 60) {
        hours++;
        minutes = 0;
        if (hours === 24) {
          hours = 0;
        }
      }
    }

    this.setState({seconds, minutes, hours});
  }

  componentDidMount(){
    this.timer = setInterval(this.tick, 1000);
  }

  componentWillUnmount(){
    clearInterval(this.timer);
    this.timer = 0;
  }

  render(){
    const {seconds, minutes, hours, day, month, year} = this.state;
    return (
      <div id="clock" className="widget">
        <h1>Clock</h1>
        <div id="time">
          <span>Time: </span>
          <span>{`${hours}: ${minutes}: ${seconds}`} PDT</span>
        </div>
        <div id="date">
          <span>Date: </span>
          <span>{`${month}-${day}-${year}`}</span>
        </div>
      </div>
    );
  }
}

export default Clock;
