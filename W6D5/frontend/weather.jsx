import React from 'react';

class Weather extends React.Component{
  constructor(){
    super();
    this.state = {city: "", temp: ""};
  }

  componentDidMount(){
    navigator.geolocation.getCurrentPosition(
      ({coords}) => {
        let lat = coords.latitude.toFixed(2);
        let lon = coords.longitude.toFixed(2);
        const xhr = new XMLHttpRequest();
        xhr.open('GET', `http://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${lon}&appid=7727a1dd265d456315162ba21763e67c`, true);

        xhr.onload = () => {
          const res = JSON.parse(xhr.responseText);
          let city = res.name;
          let temp = res.main.temp;
          temp = (9/5 * (temp - 273) + 32).toFixed(1);
          this.setState({city, temp});
        };

        xhr.send();
      }
    );
  }

  render(){
    return (
      <div className="widget" id="weather">
        <h1>Weather</h1>
        <h2>{this.state.city}</h2>
        <h2>{this.state.temp} Degrees</h2>
    </div>);
  }
}

// 7727a1dd265d456315162ba21763e67c
export default Weather;
