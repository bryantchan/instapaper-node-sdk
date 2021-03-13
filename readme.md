## Node.js wrapper for Instapaper API

### Installation
```
$ npm i instapaper-node-sdk
```

### Usage
```javascript

const Instapaper = require('instapaper-node-sdk')
const client = new Instapaper(KEY, SECRET)
client.setCredentials(USERNAME, PASSWORD)

// get the list of your bookmarks
client.list({ limit: 100 }).then((data) => console.log(data)).catch((err) => console.log(err))

```

### APIs [Instapaper API document](https://www.instapaper.com/api/full)
#### Utils
- verifyCredentials()
#### Bookmarks
- list(params)
- updateReadProgress(params)
- add(params)
- delete(bookmarkId)
- star(bookmarkId)
- unstar(bookmarkId)
- archive(bookmarkId)
- unArchive(bookmarkId)
- move(bookmarkId, folderId)
- getText(bookmarkId)

#### Folders
- listFolders(params)
- addFolder(title)
- deleteFolder(folderId)

#### Hightlights
- listHighlights(bookmarkId)
- addHighlight(bookmarkId, params)
- deleteHighlight(highlightId)


### Terms of use
Please read the [Instapaper API Terms of Use](https://www.instapaper.com/api/terms) before using this API client.

### AUTHOR
BryantChan <<bryantandk@gmail.com>>
