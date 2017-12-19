import React from 'react'
import MuiThemeProvider from 'material-ui/styles/MuiThemeProvider';
import { TextField, RaisedButton } from 'material-ui';
import { BrowserRouter, Route, Link, Redirect } from 'react-router-dom'

import { fetchApi, getApiToken, setApiToken } from './lib';
import { ArticleList } from './article';
import Signup from './signup';

class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = { apiToken: null }
  }
  componentWillMount() {
    fetchApi('/articles').then(() => {
      const apiToken = getApiToken();
      this.setState({ apiToken });
    }).catch(() => {
      const apiToken = setApiToken(null);
    })
  }


  isLoggedIn() {
    return !!this.state.apiToken;
  }

  render() {
    return (
      <MuiThemeProvider>
        <div>
          { this.isLoggedIn() ? <ArticleList /> : <Signup /> }
        </div>
      </MuiThemeProvider>
    );
  }
}
export default App;
