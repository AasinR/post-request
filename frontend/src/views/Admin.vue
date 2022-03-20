<template>
  <div class="admin">
    <Header/>
    <div class="content">
      <router-view></router-view>
    </div>
	  <Footer/>
  </div>
</template>

<script>

import Header from '@/components/Header'
import Footer from '@/components/Footer'

export default {
  name: "Admin",
  components: {
    Footer,
	  Header,
  },

}
</script>

<style scoped lang="scss">
  .admin {
    margin-left: auto;
    margin-right: auto;
    padding-top: 8vh;
    padding-bottom: 10vh;
    width: 60%;
  }
</style>