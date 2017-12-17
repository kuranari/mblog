export function fetchApi(url, params = {}) {
  const defaultHeaders = {
    Accept: 'application/json',
    'Content-Type': 'application/json',
  };

  const apiToken = getApiToken();
  if (apiToken) {
    defaultHeaders['Authorization'] = `Bearer ${apiToken}`
  }

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


const API_TOKEN_KEY = 'API_TOKEN';
export function setApiToken(token) {
  localStorage[API_TOKEN_KEY] = token;
}

export function getApiToken() {
  return localStorage[API_TOKEN_KEY];
}
