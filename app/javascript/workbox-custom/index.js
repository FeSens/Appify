const RequestCORS = {
  requestWillFetch(request) {
    // Return `request` or a different `Request` object.
    const url = new URL(request.url)
    if(url.host === "cdn.shopify.com") {
      var req = new Request(request, {
        headers: {
          ...request.headers,
          origin: location.origin
        }
      })
      return req
    }

    return request;
  }
};

export { RequestCORS }