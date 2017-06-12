
crypto = require "crypto"
path = require "path"
fs = require "fs"

module.exports = (file, data) ->
  dir = path.dirname file
  tmp = path.join dir, tmpname file
  new Promise (resolve, reject) ->
    fs.writeFile tmp, data, (error) ->
      return reject error if error
      fs.rename tmp, file, (error) ->
        if error
        then reject error
        else resolve()

#
# Helpers
#

md5 = (data) ->
  sum = crypto.createHash "md5"
  sum.update data
  sum.digest "hex"

tmpname = (file) ->
  prefix = md5 Date.now().toString() + file
  ".#{prefix}." + path.basename file
