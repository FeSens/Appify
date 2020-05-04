import { registerRoute, setCatchHandler} from 'workbox-routing';
import { CacheFirst, StaleWhileRevalidate, NetworkFirst, NetworkOnly } from 'workbox-strategies';
import { CacheableResponsePlugin } from 'workbox-cacheable-response';
import { ExpirationPlugin } from 'workbox-expiration';
import { precacheAndRoute } from 'workbox-precaching';
//This is the service worker with the Advanced caching
const HTML_CACHE = "html";
const JS_CACHE = "javascript";
const STYLE_CACHE = "stylesheets";
const IMAGE_CACHE = "images";
const FONT_CACHE = "fonts";
const CACHE = "pwabuilder-offline";

self.addEventListener("message", (event) => {
  if (event.data && event.data.type === "SKIP_WAITING") {
    self.skipWaiting();
  }
});

// This is the "Offline copy of assets" service worker

self.addEventListener("message", (event) => {
  if (event.data && event.data.type === "SKIP_WAITING") {
    self.skipWaiting();
  }
});

registerRoute(
  new RegExp('/*'),
  new StaleWhileRevalidate({
    cacheName: CACHE
  })
);

registerRoute(
  ({event}) => event.request.destination === 'document',
  new NetworkFirst({
    cacheName: HTML_CACHE,
    plugins: [
      new ExpirationPlugin({
        maxEntries: 10,
      }),
    ],
  })
);

registerRoute(
  ({event}) => event.request.destination === 'script',
  new StaleWhileRevalidate({
    cacheName: JS_CACHE,
    plugins: [
      new ExpirationPlugin({
        maxEntries: 15,
      }),
    ],
  })
);

registerRoute(
  ({event}) => event.request.destination === 'style',
  new StaleWhileRevalidate({
    cacheName: STYLE_CACHE,
    plugins: [
      new ExpirationPlugin({
        maxEntries: 15,
      }),
    ],
  })
);

registerRoute(
  ({event}) => event.request.destination === 'image',
  new StaleWhileRevalidate({
    cacheName: IMAGE_CACHE,
    plugins: [
      new ExpirationPlugin({
        maxEntries: 15,
      }),
    ],
  })
);

registerRoute(
  ({event}) => event.request.destination === 'font',
  new StaleWhileRevalidate({
    cacheName: FONT_CACHE,
    plugins: [
      new ExpirationPlugin({
        maxEntries: 15,
      }),
    ],
  })
);
