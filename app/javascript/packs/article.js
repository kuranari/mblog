import React from 'react'
import {Card, CardActions, CardHeader, CardText} from 'material-ui/Card';
import FlatButton from 'material-ui/FlatButton';
import { TextField, RaisedButton } from 'material-ui';
import { fetchApi, setApiToken } from './lib';

const Article = ({ id, user, title, body }) => (
  <Card>
    <CardHeader
      title={title}
      actAsExpander={true}
      showExpandableButton={true}
    />
    <CardText expandable={true}>
      {body}
    </CardText>
  </Card>
);

export class ArticleForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      title: '',
      body: ''
    }
    this.onSubmit = this.onSubmit.bind(this);
  }

  handleChange = name => event => {
    this.setState({
      [name]: event.target.value
    });
  };

  onSubmit() {
    fetchApi('/articles', {
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
            floatingLabelText="タイトル"
            value={this.state.title}
            onChange={this.handleChange('title')}
          />
        </div>
        <div>
          <TextField
            floatingLabelText="本文"
            value={this.state.body}
            onChange={this.handleChange('body')}
            multiLine
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

export class ArticleList extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      articles: [],
    }
  }

  componentWillMount() {
    fetchApi('/articles', {
    }).then(articles => {
      this.setState({ articles })
    }).catch(error => {
      console.log(error)
    })
  }

  renderArticles() {
    return this.state.articles.map(article => (
      <Article key={article.id} {...article} />
    ))
  }

  render() {
    return (
      <div>
        <div>Artilecs</div>
        { this.renderArticles() }
      </div>
    );
  }
}
