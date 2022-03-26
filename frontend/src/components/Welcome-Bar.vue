<template>
  <div class="welcome-bar">
    <img class="logo" src="@/assets/logo.png" alt="logo">
    <h1>Welcome to <br/> <span>PostRequest!</span></h1>
  </div>
</template>

<script>
export default {
  name: "Welcome-Bar"
}
</script>

<style lang="scss" scoped>
  .welcome-bar {
    position: absolute;
    top: 0;
    left: 0;
    height: 100vh;
    width: 45%;
    background-color: var(--dark-bg-color);
    font-family: "Century Gothic", sans-serif;

    .logo {
      width: 10%;
      margin-top: 7%;
      margin-left: 7%;
    }

    span {
      font-size: 5rem;
    }

    h1{
      text-align: center;
      margin-top: 25%;
      font-size: 4rem;
    }


  }

</style>