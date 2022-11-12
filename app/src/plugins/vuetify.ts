// Styles
//import '@mdi/font/css/materialdesignicons.css';
import 'vuetify/styles';
//import '../../node_modules/front-end-component-library/dist/style.css';

// Vuetify
//import '@fortawesome/fontawesome-free/css/all.css';
import '@mdi/font/css/materialdesignicons.css'
import { createVuetify } from 'vuetify';
import { aliases, mdi } from 'vuetify/iconsets/mdi'
import * as components from 'vuetify/components';
import * as directives from 'vuetify/directives';

export default createVuetify({
    icons: {
        defaultSet: 'mdi',
        aliases,
        sets: {
            mdi
        }
    },
    components,
    directives,
});
