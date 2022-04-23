<template>
  <div class="notfound">
    <Header/>
    <Navbar/>
    <div class="content">
      <h1>Not Authorized!</h1>
      <img id="stop-img" src="@/assets/notfound.png" alt="stop"/>
    </div>
    <Footer/>
  </div>
</template>

<script>
import Footer from "@/components/Footer";
import Navbar from "@/components/Navbar";
import Header from "@/components/Header";

export default {
  name: "NotFound",
  components: {Footer, Navbar, Header}
}
</script>

<style lang="scss" scoped>
  .notfound{
    padding-top: 8vh;
    padding-bottom: 10vh;
  .content {
    margin-left: auto;
    margin-right: auto;
    width: 60%;

    #stop-img {
      width: 50%;
      display: block;
      margin-left: auto;
      margin-right: auto;
    }
  }
}
</style>