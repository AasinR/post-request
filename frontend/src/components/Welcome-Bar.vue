<template>
  <div class="welcome-bar">
    <img class="logo" src="@/assets/logo.png" alt="logo">
    <h1>Welcome to <br/> <span>PostRequest!</span></h1>
    <p>Description Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
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
    background-color: #162233;
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
      margin-top: 20%;
      font-size: 4rem;
    }

    p {
      margin-top: 5%;
      margin-left: 20%;
      margin-right: 20%;
      text-align: justify;
      font-size: 1.1rem;
    }

  }

</style>