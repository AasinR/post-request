<template>
  <div class="friends">
    <Header/>
    <Navbar current="friends"/>
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
  name: "Friends",
  components: {
    Header,
    Navbar,
    Footer,
  }
}
</script>

<style lang="scss" scoped>

  .friends{
    padding-top: 8vh;
    padding-bottom: 10vh;
    .content {
      margin-left: auto;
      margin-right: auto;
      width: 60%;
    }
  }

</style>