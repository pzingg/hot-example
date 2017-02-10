# hot-example

SSCCE showing problems with handsontable 'hot-table' web component
in different browsers.

See https://github.com/handsontable/hot-table for information about the
component.

This demonstration app built with create-elm-app (webpack dev system).

Hot-table bower component installed with `bower install hot-table`

Polyfill for Safari and Firefox installed in src/index.js, based on
suggestions in https://www.polymer-project.org/1.0/docs/browsers


## Test Results

When viewed in Chrome with Polymer.dom is set to 'shadow',
the hot-table displays with correct styles and positioning, using the
native support for webcomponents that is built into Chrome.

In Safari and Firefox the grid will display inaccurately
(headers shown at top of screen, no grid borders, etc.), no matter what
Polymer.dom setting is used.  The same result shows up in Chrome
if Polymer.dom is set to 'shady' (the default).

You can adjust this setting in src/index.js.

See the visual results by looking at [Issue #1](https://github.com/pzingg/hot-example/issues/1)
in the Github repository


## Colophon

This project was bootstrapped with [Create Elm App](https://github.com/halfzebra/create-elm-app).
