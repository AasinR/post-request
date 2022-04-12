import Vue from 'vue'
import App from './App.vue'
import router from './router'
import VueCookies from 'vue-cookies'

import axios from "axios";

axios.defaults.withCredentials = true;
Vue.prototype.axios = axios;
Vue.config.productionTip = false;
Vue.use(VueCookies);
Vue.$cookies.config("7d");

new Vue({
  data(){
    return{
      requestURL: process.env.VUE_APP_REQUEST_URL
    }
  },
  router,
  render: h => h(App)
}).$mount('#app')
