<template>
  <div class="header">
    <img class="logo" src="@/assets/logo.png" alt="logo">
    <p class="title">PostRequest</p>
  </div>
</template>

<script>
export default {
	name: "Header"
}
</script>

<style lang="scss" scoped>
.header{
  background-color: var(--accent-color);
  position: fixed;
  left: 0;
  top: 0;
  width: 100vw;
  height: 5vh;
  display: flex;
  flex-direction: row;
  align-items: center;

  .logo{
    height: 80%;
    margin-left: 20%;
  }
  .title{
    color: var(--font-color);
    font-family: "Century Gothic", sans-serif;
    font-size: 1.5rem;
    font-weight: bold;
    margin-left: 1%;

  }
}
</style>