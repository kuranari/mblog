import React from 'react'
import MuiThemeProvider from 'material-ui/styles/MuiThemeProvider';
import { TextField, RaisedButton } from 'material-ui';
import { BrowserRouter, Route, Link, Redirect } from 'react-router-dom'

import { fetchApi, getApiToken } from './lib';
import { ArticleList, ArticleForm } from './article';
import Signup from './signup';

class App extends React.Component {
  componentWillMount() {
    const apiToken = getApiToken();
    this.setState({ apiToken });
  }

  isLoggedIn() {
    return !!this.state.apiToken;
  }

  render() {
    return (
      <BrowserRouter>
        <MuiThemeProvider>
        <div>
          <Route exact path='/' component={ArticleList} />
          {
            this.isLoggedIn() ? null : <Redirect to='/signup'/>
          }
        </div>
        </MuiThemeProvider>
      </BrowserRouter>
    );
  }
}
export default App;
