const path = require('path');
const express = require('express');
const app = express();
const PORT = process.env.PORT || 3001;

if (fs.existsSync(path.resolve('build/index.html'))) {
  var sslRedirect = require('heroku-ssl-redirect');
  app.use(sslRedirect());

  app.use("/", express.static(path.resolve('build')));
  app.use("/assets", express.static(path.resolve('source/assets')));

  app.get("*", function(request, response) {
    response.sendFile(path.resolve('build/index.html'));
  });
}

app.listen(PORT, error => {
  error
  ? console.error(error)
  : console.info(`==> 🌎 Listening on port ${PORT}. Visit http://localhost:${PORT}/ in your browser.`)
});
