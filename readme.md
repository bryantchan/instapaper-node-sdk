# Instapaper api for node.js

## Usage
```

const Instapaper = require('./index')

const client = new Instapaper(KEY, SECRET)

client.requestToken().then(function(data){
    const token = data.oauth_token
    const secret = data.oauth_secret
})

// setToken
client.setToken(TOKEN, SECRET)

client.listBookmarks().then(function(bookmarks){
    //...
}).catch(function(err){
    console.error(err)
})

```

## Todos
- Add error handling