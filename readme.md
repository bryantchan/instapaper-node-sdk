## Instapaper APIs for Node.js

### Installation
```
$ npm i instapaper-node-sdk
```

### Usage
```javascript

const Instapaper = require('instapaper-node-sdk')
const client = new Instapaper(KEY, SECRET)

client.login(username, password).then(() => {
    client.listBookmarks().then(function(bookmarks){
        //...
    }).catch(function(err){
        console.error(err)
    })
})
```

### APIs [Instapaper API document](https://www.instapaper.com/api/full)
#### Utils
- requestToken(user, password)
- setToken(token, secret)
- verifyCredentials
- login(user, password)

#### Bookmarks
- listBookmarks(params)
- updateBookmark(params)
- addBookmark(params)
- deleteBookmark(bookmark_id)
- starBookmark(bookmark_id)
- unstarBookmark(bookmark_id)
- archiveBookmark(bookmark_id)
- unarchiveBookmark(bookmark_id)
- moveBookmark(bookmark_id, folder_id)
- getText(bookmark_id)

#### Folders
- listFolders
- addFolder(title)
- deleteFolder(folder_id)

### Todos
- Add error handling

### Terms of use
Please read the [Instapaper API Terms of Use](https://www.instapaper.com/api/terms) before using this API client.

### AUTHOR
BryantChan <<bryantandk@gmail.com>>
