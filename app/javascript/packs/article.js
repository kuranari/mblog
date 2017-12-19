import React from 'react'
import {Card, CardActions, CardHeader, CardText} from 'material-ui/Card';
import FlatButton from 'material-ui/FlatButton';
import { TextField, RaisedButton } from 'material-ui';
import IconButton from 'material-ui/IconButton';

import { fetchApi, setApiToken } from './lib';


const Article = ({ id, user, title, body, onDelete }) => (
  <Card>
    <CardHeader
      title={title}
      subtitle={user.email}
      actAsExpander={true}
      showExpandableButton={true}
    />
    <CardActions>
      <FlatButton label="削除" onClick={() => onDelete(id)} />
    </CardActions>
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
      this.props.onSubmitSuccess();
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
    this.fetchArticles = this.fetchArticles.bind(this);
    this.deleteArticle = this.deleteArticle.bind(this);
  }

  componentWillMount() {
    this.fetchArticles();
  }

  fetchArticles() {
    fetchApi('/articles').then(articles => {
      this.setState({ articles })
    }).catch(error => {
      console.log(error)
    })
  }

  deleteArticle(id) {
    fetchApi(`/articles/${id}`, {
      method: 'DELETE',
    }).then(response => {
      this.fetchArticles();
    }).catch(error => {
      alert(error.message)
    })
  }

  renderArticles() {
    return this.state.articles.map(article => (
      <Article key={article.id} onDelete={this.deleteArticle} {...article} />
    ))
  }

  render() {
    return (
      <div>
        <h2>新規記事投稿フォーム</h2>
        <ArticleForm onSubmitSuccess={this.fetchArticles} />

        <h2>記事一覧</h2>
        { this.renderArticles() }
      </div>
    );
  }
}
