import "./../src/application.css"

const Rails = require('rails-ujs');
Rails.start();

import Turbolinks from "turbolinks";
Turbolinks.start();

// import Filter from 'components/filter'

import WebpackerReact from 'webpacker-react'

// WebpackerReact.setup({Filter})

document.addEventListener("turbolinks:load", function() {
  $('pre code').each(function(i, block) {
    hljs.highlightBlock(block);
  });
})