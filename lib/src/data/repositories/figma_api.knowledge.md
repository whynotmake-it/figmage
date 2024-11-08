GET image
Renders images from a file.

Important implementation notes:
- Use scale parameter to generate different resolutions (e.g. 1x, 2x, 3x)
- Format can be jpg, png, svg, or pdf
- Node IDs can be batched in a single request with comma separation
- Images expire after 30 days
- Max image size is 32 megapixels
- Invisible nodes or 0% opacity nodes will return null in response
- SVG options available for text handling and stroke simplification

If no error occurs, "images" will be populated with a map from node IDs to URLs of the rendered images, and "status" will be omitted. The image assets will expire after 30 days. Images up to 32 megapixels can be exported. Any images that are larger will be scaled down.

Important: the image map may contain values that are null. This indicates that rendering of that specific node has failed. This may be due to the node id not existing, or other reasons such has the node having no renderable components. For example, a node that is invisible or has 0% opacity cannot be rendered. It is guaranteed that any node that was requested for rendering will be represented in this map whether or not the render succeeded.

To render multiple images from the same file, use the ids query parameter to specify multiple node ids.GET /v1/images/:key?ids=1:2,1:3,1:4

HTTP Endpoint
GET/v1/images/:key

Path parameters Description
key String
File to export images from. This can be a file key or branch key. Use GET /v1/files/:key with the branch_data query param to get the branch key.
Query parameters Description
ids String
A comma separated list of node IDs to render
scale Numberoptional
A number between 0.01 and 4, the image scaling factor
format Stringoptional
A string enum for the image output format, can be jpg, png, svg, or pdf
svg_outline_text Booleanoptional
Whether text elements are rendered as outlines (vector paths) or as <text> elements in SVGs. Default: true.

Rendering text elements as outlines guarantees that the text looks exactly the same in the SVG as it does in the browser/inside Figma.

Exporting as <text> allows text to be selectable inside SVGs and generally makes the SVG easier to read. However, this relies on the browser's rendering engine which can vary between browsers and/or operating systems. As such, visual accuracy is not guaranteed as the result could look different than in Figma.
svg_include_id Booleanoptional
Whether to include id attributes for all SVG elements. Adds the layer name to the id attribute of an svg element. Default: false.
svg_include_node_id Booleanoptional
Whether to include node id attributes for all SVG elements. Adds the node id to a data-node-id attribute of an svg element. Default: false.
svg_simplify_stroke Booleanoptional
Whether to simplify inside/outside strokes and use stroke attribute if possible instead of <mask>. Default: true.
contents_only Booleanoptional
Whether content that overlaps the node should be excluded from rendering. Passing false (i.e., rendering overlaps) may increase processing time, since more of the document must be included in rendering. Default: true.
use_absolute_bounds Booleanoptional
Use the full dimensions of the node regardless of whether or not it is cropped or the space around it is empty. Use this to export text nodes without cropping. Default: false.
version Stringoptional
A specific version ID to use. Omitting this will use the current version of the file
Error codes Description
400 Invalid parameter, the "err" property will indicate which parameter is invalid
403 The developer / OAuth token is invalid or expired
404 The specified file was not found
500 Unexpected rendering error, render could not be completed

GET file
Returns the document referred to by :key as a JSON object. The file key can be parsed from any Figma file url: https://www.figma.com/:file_type/:file_key/:file_name. The name, lastModified, thumbnailUrl, editorType, linkAccess, and version attributes are all metadata of the retrieved file. The document attribute contains a Node of type DOCUMENT.

The components key contains a mapping from node IDs to component metadata. This is to help you determine which components each instance comes from.

HTTP Endpoint
GET/v1/files/:key

Path parameters Description
key String
File to export JSON from. This can be a file key or branch key. Use GET /v1/files/:key with the branch_data query param to get the branch key.
Query parameters Description
version Stringoptional
A specific version ID to get. Omitting this will get the current version of the file
ids Stringoptional
Comma separated list of nodes that you care about in the document. If specified, only a subset of the document will be returned corresponding to the nodes listed, their children, and everything between the root node and the listed nodes.

Note: There may be other nodes included in the returned JSON that are outside the ancestor chains of the desired nodes. The response may also include dependencies of anything in the nodes' subtrees. For example, if a node subtree contains an instance of a local component that lives elsewhere in that file, that component and its ancestor chain will also be included.

For historical reasons, top-level canvas nodes are always returned, regardless of whether they are listed in the ids parameter. This quirk may be removed in a future version of the API.
depth Numberoptional
Positive integer representing how deep into the document tree to traverse. For example, setting this to 1 returns only Pages, setting it to 2 returns Pages and all top level objects on each page. Not setting this parameter returns all nodes
geometry Stringoptional
Set to "paths" to export vector data
plugin_data Stringoptional
A comma separated list of plugin IDs and/or the string "shared". Any data present in the document written by those plugins will be included in the result in the `pluginData` and `sharedPluginData` properties.
branch_data Booleanoptional
Returns branch metadata for the requested file. If the file is a branch, the main file's key will be included in the returned response. If the file has branches, their metadata will be included in the returned response. Default: false.
Error codes Description
403 The developer / OAuth token is invalid or expired
404 The specified file was not found
Return value
{
"name": String,
"role": String,
"lastModified": String,
"editorType": String,
"thumbnailUrl": String,
"version": String,
"document": Node,
"components": Map<String, Component>,
"componentSets": Map<String, ComponentSet>,
"schemaVersion": 0,
"styles": Map<String, Style>
"mainFileKey": String,
"branches": [
{
"key": String,
"name": String,
"thumbnail_url": String,
"last_modified": String,
"link_access": String,
}
]
}
Try it out for yourself

Your cURL command
curl -H 'X-FIGMA-TOKEN: figd*ptut759TO2Gl*-zFaEBc4cnVU3agDsHUcnd9efN7' 'https://api.figma.com/v1/files/:file_key'
Examples
To get the JSON for specific nodes, their subtrees, and all the nodes in their ancestor chains:

GET /v1/files/:key?ids=1:2,1:3
To get the JSON for the document tree stopping at the top-level nodes on each page (all pages live at depth 1):

GET /v1/files/:key?depth=2
