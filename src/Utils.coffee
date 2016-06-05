module.exports =\

##
# Utility functions for ocrrect
class Utils

	##
	# Convert a URI to a cache-key string.
	# @param {String} uri URI to convert to a cache key
	# @example
	#     Utils.uriToFilename("http://example.org/foo")
	#     # -> 'example_org_foo'
	@uriToFilename : (uri) ->
		uri = uri.replace /[^a-zA-Z0-9]/g, '_'
		uri = uri.replace /_{2,}/g, '_'
		uri = uri.replace /^https?_/, ''
		return uri

