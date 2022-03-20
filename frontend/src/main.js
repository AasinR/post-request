import Vue from 'vue'
import App from './App.vue'
import router from './router'

import axios from "axios";
Vue.prototype.axios = axios;
Vue.config.productionTip = false


new Vue({
  data(){
    return{
      requestURL: process.env.VUE_APP_REQUEST_URL
    }
  },
  router,
  render: h => h(App)
}).$mount('#app')
