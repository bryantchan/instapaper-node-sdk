request = require('request-promise')
OAuth = require('oauth-1.0a')
crypto = require('crypto')

class Instapaper

  baseUrl: 'https://www.instapaper.com/api/1/'
  consumer_key: ''
  consumer_secret: ''
  oauth: null
  token: null

  constructor: (@consumer_key, @consumer_secret) ->
    @oauth = OAuth
      consumer:
        key: @consumer_key
        secret: @consumer_secret
      signature_method: 'HMAC-SHA1',
      hash_function: (base_string, key) ->
        crypto.createHmac('sha1', key).update(base_string).digest('base64')

  request: (opts, callback) ->
    opts.url = @baseUrl + opts.url
    opts.method = 'POST'

    if @token
      opts.form = @oauth.authorize(opts)
      opts.headers = @oauth.toHeader(@oauth.authorize(opts, @token))

    else if opts.url.indexOf('access_token') > 0
      opts.form = this.oauth.authorize(opts)

    else
      opts.form = opts.data

    return new Promise (resolve, reject) ->
      request(opts).then((data) ->
        if opts.format is 'raw'
          resolve data
        else if opts.format is 'qline'
          resolve qline2object(data)
        else
          resolve JSON.parse data
      ).catch (error) ->
        reject error

  requestToken: (user, password) ->
    @request
      format: 'qline'
      url: 'oauth/access_token'
      data:
        x_auth_username: user
        x_auth_password: password
        x_auth_mode: 'client_auth'

  setToken: (token, secret) ->
    @token =
      key: token
      secret: secret

  verifyCredentials: ->
    @request
      url: 'account/verify_credentials'

  login: (user, password) ->
    vm = @
    return new Promise (resolve, reject) ->
      vm.requestToken(user, password).then((authData) ->
        vm.setToken authData.oauth_token, authData.oauth_token_secret
        resolve()
      ).catch (err) ->
        reject err

  listBookmarks: (params = {}) ->
    @request
      url: 'bookmarks/list'
      data: params

  updateBookmarkProgress: (params = {}) ->
    @request
      url: 'bookmarks/update_read_progress'
      data: params

  addBookmark: (params = {}) ->
    @request
      url: 'bookmarks/add'
      data: params

  deleteBookmark: (bookmark_id) ->
    @request
      url: 'bookmarks/delete'
      data:
        bookmark_id: bookmark_id

  starBookmark: (bookmark_id) ->
    @request
      url: 'bookmarks/star'
      data:
        bookmark_id: bookmark_id

  unstarBookmark: (bookmark_id) ->
    @request
      url: 'bookmarks/unstar'
      data:
        bookmark_id: bookmark_id

  archiveBookmark: (bookmark_id) ->
    @request
      url: 'bookmarks/archive'
      data:
        bookmark_id: bookmark_id

  unarchiveBookmark: (bookmark_id) ->
    @request
      url: 'bookmarks/unarchive'
      data:
        bookmark_id: bookmark_id

  moveBookmark: (bookmark_id, folder_id) ->
    @request
      url: 'bookmarks/unarchive'
      data:
        bookmark_id: bookmark_id
        folder_id: folder_id

  getText: (bookmark_id) ->
    @request
      format: 'raw'
      url: 'bookmarks/get_text'
      data:
        bookmark_id: bookmark_id

  listFolders: ->
    @request
      url: 'folders/list'

  addFolder: (title) ->
    @request
      url: 'folders/add'
      data:
        title: title

  deleteFolder: (folder_id) ->
    @request
      url: 'folders/delete'
      data:
        folder_id: folder_id

qline2object = (query = "") ->
  result = {}
  parts = query.split("&")
  for item in parts
    item = item.split("=")
    result[item[0]] = item[1]
  result

module?.exports = Instapaper
