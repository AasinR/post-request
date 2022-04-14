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
  methods: {
    isLoggedIn(){
      const userId = this.$cookies.get('UserID');
      return userId !== '' && userId !== undefined && userId !== null;
    },
    async isAdmin(){
      try {
        const response = await this.axios.get(`${this.$root.requestURL}/user/get/${this.$cookies.get("UserID")}`);
        return response.data.result.PERMISSION === 1;
      } catch (err) {
        console.log(err.response.data);
        return false;
      }
    },
  },
  router,
  render: h => h(App)
}).$mount('#app')
