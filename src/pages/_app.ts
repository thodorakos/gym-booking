import type { App } from 'vue';
import PrimeVue from 'primevue/config';
import Aura from '@primevue/themes/aura';
import AnimateOnScroll from 'primevue/animateonscroll';
import { primeVuePt } from '../config/primevue';

export default (app: App) => {
  app.use(PrimeVue, {
    theme: {
      preset: Aura,
      options: {
        darkModeSelector: '.dark',
      }
    },
    ripple: true
  });
  
  app.directive('animateonscroll', AnimateOnScroll);
};
