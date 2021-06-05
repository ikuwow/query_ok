// Font awesome
// see: https://fontawesome.com/how-to-use/with-the-api/setup/getting-started
import { library, dom } from '@fortawesome/fontawesome-svg-core';
import { faTag } from '@fortawesome/free-solid-svg-icons';
import { faTwitter, faGithub, faFacebookSquare, faInstagram } from '@fortawesome/free-brands-svg-icons';

library.add(
  faTag,
  faTwitter,
  faGithub,
  faFacebookSquare,
  faInstagram
);
dom.i2svg();

import './stylesheets/babylink.scss'
