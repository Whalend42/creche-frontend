// Styles
import 'vuetify/styles';

// Vuetify
import '@mdi/font/css/materialdesignicons.css'
import { createVuetify } from 'vuetify';
import { aliases, mdi } from 'vuetify/iconsets/mdi'
import * as components from 'vuetify/components';
import * as directives from 'vuetify/directives';

const customLightTheme = {
    dark: false,
    colors: {
        /*background: '#FFFFFF',
        surface: '#FFFFFF',*/
        primary: '#3F51B5',
        warning: '#C62828'
        /*'primary-darken-1': '#3700B3',
        secondary: '#03DAC6',
        'secondary-darken-1': '#018786',
        error: '#B00020',
        info: '#2196F3',
        success: '#4CAF50',
        warning: '#FB8C00',*/
    }
};
const customDarkTheme = {
    dark: true,
    colors: {
        primary: '#2196F3'
    }
};


export default createVuetify({
    icons: {
        defaultSet: 'mdi',
        aliases,
        sets: {
            mdi
        }
    },
    theme: {
        defaultTheme: 'customLightTheme',
        themes: {
          customLightTheme,
          customDarkTheme,
        },
      },
    components,
    directives,
});
