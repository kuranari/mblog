export function fetchApi(url, params = {}) {
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
