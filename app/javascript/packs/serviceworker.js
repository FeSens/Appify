import { registerRoute, setCatchHandler} from 'workbox-routing';
import { CacheFirst, StaleWhileRevalidate, NetworkFirst, NetworkOnly } from 'workbox-strategies';
import { CacheableResponsePlugin } from 'workbox-cacheable-response';
import { ExpirationPlugin } from 'workbox-expiration';
import { precacheAndRoute } from 'workbox-precaching';

precacheAndRoute([
  {url: '/offline', revision: null },
]);

setCatchHandler(({url, event, params}) => {
  return caches.match('/offline')
});

// Cache the Google Fonts stylesheets with a stale while revalidate strategy.
registerRoute(
   /^((?!png|gif|jpg|jpeg|svg|js|css|facebook|woff2|google).)*$/,
  new NetworkFirst({
    cacheName: 'Get Queries',
    plugins: [
      new CacheableResponsePlugin({
        statuses: [200],
      }),
      new ExpirationPlugin({
        maxEntries: 50,
        maxAgeSeconds: 7 * 24 * 60 * 60,
        purgeOnQuotaError: true,
      }),
    ]
  }),
)

// Cache Javascript and CSS 
registerRoute(
  /(?:js|css)$/, 
  new NetworkFirst({
    cacheName: 'JS and CSS Assets',
    plugins: [
      new ExpirationPlugin({
        maxEntries: 10,
        maxAgeSeconds: 7 * 24 * 60 * 60,
        purgeOnQuotaError: true,
      }),
    ]
  }),
)

// Cache the Google Fonts webfont files with a cache first strategy for 1 year.
registerRoute(
  /(?:fonts|woff2)/,
  new StaleWhileRevalidate({
    cacheName: 'fonts-webfonts',
    plugins: [
      new CacheableResponsePlugin({
        statuses: [0, 200],
      }),
      new ExpirationPlugin({
        maxAgeSeconds: 60 * 60 * 24 * 7,
        maxEntries: 10,
        purgeOnQuotaError: true,
      }),
    ],
  }),
);
