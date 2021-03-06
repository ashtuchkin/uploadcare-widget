{namespace, jQuery: $, utils} = uploadcare

namespace 'uploadcare.files', (ns) ->

  class ns.UploadedFile extends ns.BaseFile
    constructor: (settings, fileIdOrUrl) ->
      super

      id = utils.uuidRegex.exec(fileIdOrUrl)
      if id
        @fileId = id[0]
        modifiers = utils.cdnUrlModifiersRegex.exec(fileIdOrUrl)
        @cdnUrlModifiers = modifiers if modifiers
        @cdnUrl = "#{@settings.cdnBase}/#{@fileId}/#{@cdnUrlModifiers or ''}"
        @__buildPreviewUrl()
        @__uploadDf.resolve(this)
      else
        @__uploadDf.reject('baddata', this)

    __startUpload: ->
      # nothing to do
