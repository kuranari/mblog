import React from 'react'
import MuiThemeProvider from 'material-ui/styles/MuiThemeProvider';
import { TextField, RaisedButton, Paper } from 'material-ui';

const App = () => (
  <MuiThemeProvider>
    <SessionForm />
  </MuiThemeProvider>
)
export default App;

function fetchApi(url, params) {
  const defaultHeaders = {
    Accept: 'application/json',
    'Content-Type': 'application/json',
  };

  return fetch(url, {
    headers: defaultHeaders,
    ...params
  })
  .then(response => (
    response.text().then(text => (
      {
        json: text ? JSON.parse(text) : {},
        response,
      }
    ))
  ))
  .then(({ json, response }) => {
    if (!response.ok) {
      throw json;
    }
    return json;
  })
}

class SessionForm extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      email: '',
      password: '',
    };

    this.handleChange = this.handleChange.bind(this);
    this.onSubmit = this.onSubmit.bind(this);
  }

  handleChange = name => (event) => {
    this.setState({
      [name]: event.target.value
    });
  };

  onSubmit() {
    fetchApi('/users', {
      method: 'POST',
      body: JSON.stringify(this.state),
    }).then(response => {
      console.log(response)
    }).catch(error => {
      alert(error.message)
    })
  }

  render() {
    return (
      <div>
        <div>
          <TextField
            floatingLabelText="email"
            value={this.state.email}
            onChange={this.handleChange('email')}
          />
        </div>
        <div>
          <TextField
            floatingLabelText="password"
            value={this.state.password}
            onChange={this.handleChange('password')}
            type="password"
          />
        </div>
        <div>
          <RaisedButton
            label="送信"
            primary
            onClick={this.onSubmit}
          />
        </div>
      </div>
    );
  }
}
