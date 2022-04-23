<template>
  <div class="admin">
    <Header/>
    <Navbar current="admin"/>
    <div class="content">
      <router-view></router-view>
    </div>
	  <Footer/>
  </div>
</template>

<script>

import Header from '@/components/Header'
import Footer from '@/components/Footer'
import Navbar from "@/components/Navbar"

export default {
  name: "Admin",
  components: {
    Navbar,
    Footer,
	  Header,
  },

}
</script>

<style scoped lang="scss">

  .admin{
    padding-top: 8vh;
    padding-bottom: 10vh;
    .content {
      margin-left: auto;
      margin-right: auto;
      width: 60%;
    }
  }

</style>