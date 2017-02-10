require('./main.css');

var Elm = require('./Main.elm');

var root = document.getElementById('root');

Elm.Main.embed(root);

// Webcomponents compatibilty check
// See https://www.polymer-project.org/1.0/docs/browsers
if ('registerElement' in document
    && 'import' in document.createElement('link')
    && 'content' in document.createElement('template')) {

    // platform is good!
    console.log('Using native webcomponents');
} else {

    // polyfill the platform!
    console.log('Using webcomponents polyfill');
    var e = document.createElement('script');
    e.src = 'bower_components/webcomponentsjs/webcomponents.min.js';
    document.body.appendChild(e);
}

// Use shadow DOM for handsontable
// See https://groups.google.com/forum/#!msg/elm-discuss/8Q2xwRh6UYc/tGem48QjAQAJ
// and https://www.polymer-project.org/1.0/docs/devguide/settings

// Change domType = 'shadow' to domType = 'shady' to avoid one bug and cause
// another in Safari and Chrome.
var domType = 'shadow';

console.log('Polymer.dom set to ' + domType);
window.Polymer = {
    dom: domType
};

// All set, load the hot-table component now.
console.log('Creating hot-table import link');
var l = document.createElement('link');
l.rel = 'import';
l.href = 'bower_components/hot-table/hot-table.html';
// link.setAttribute('async', ''); // optionally make it async
document.head.appendChild(l);
