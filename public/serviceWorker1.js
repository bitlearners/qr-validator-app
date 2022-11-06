// serviceWorker.js

console.log("hello")
var static = "oneuiux-v2 Finance";
var cacheassets = [
    "/signup.html",
    "/assets/css/style.css",
    "/assets/js/app.js",
    '<%= javascript_path("popper.min.js") %>',
    '<%= javascript_path("color-scheme.js") %>',
    '<%= javascript_path("jquery.cookie.js") %>',
    '<%= javascript_path("main.js") %>',
    '<%= javascript_path("pwa-services.js") %>'
];

self.addEventListener("install", function (event) {
    console.log("we are here") ;
    event.waitUntil(
        caches.open(static).then(function (cache) {
            cache.addAll(cacheassets);
        }).then(function () {
            return self.skipWaiting();
        })
    );
});
self.addEventListener("activate", function (event) { });

self.addEventListener("fetch", function (event) {
    event.respondWith(
        caches.match(event.request).then(function (response) {
            return response || fetch(event.request)
        })
    );
});