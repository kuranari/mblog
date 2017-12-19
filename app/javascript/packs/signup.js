import React from 'react'
import { fetchApi, setApiToken } from './lib';
import { TextField, RaisedButton } from 'material-ui';

export default class Signup extends React.Component {
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
    fetchApi('/signup', {
      method: 'POST',
      body: JSON.stringify(this.state),
    }).then(response => {
      setApiToken(response.api_token);
    }).catch(error => {
      alert(error.message)
    })
  }

  render() {
    return (
      <div>
        <h2>新規ユーザー登録</h2>
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
