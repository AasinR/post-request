<template>
  <div class="profile">
    <Header/>
    <Navbar current="profile"/>
    <div class="content">



    </div>
    <Footer/>
  </div>
</template>

<script>
import Header from "@/components/Header";
import Navbar from "@/components/Navbar";
import Footer from "@/components/Footer";

export default {
  name: "Profile",
  components: {
    Footer,
    Navbar,
    Header,
  }
}
</script>

<style lang="scss" scoped>

  .profile{
    padding-top: 8vh;
    padding-bottom: 10vh;
    .content {
      margin-left: auto;
      margin-right: auto;
      width: 60%;
    }
  }

</style>