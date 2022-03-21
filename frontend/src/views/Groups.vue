<template>
  <div class="groups">
    <Header/>
    <Navbar current="groups"/>
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
  name: "Groups",
  components: {Footer, Navbar, Header}
}
</script>

<style lang="scss" scoped>

  .groups{
    padding-top: 8vh;
    padding-bottom: 10vh;
    .content {
      margin-left: auto;
      margin-right: auto;
      width: 60%;
    }
  }

</style>