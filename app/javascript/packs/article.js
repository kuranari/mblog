import React from 'react'
import {Card, CardActions, CardHeader, CardText} from 'material-ui/Card';
import FlatButton from 'material-ui/FlatButton';
import { fetchApi } from './lib';

const Article = ({ user, title, body, }) => (
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

class ArticleList extends React.Component {
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
      <Article {...article} />
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


export default ArticleList;
