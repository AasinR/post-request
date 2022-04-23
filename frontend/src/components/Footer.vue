<template>
  <div class="footer">
    <img class="logo" src="@/assets/logo.png" alt="logo">
    <p class="names">Mészáros Richárd<br>Sándor Balázs<br>Virágh Vivien</p>
  </div>
</template>

<script>
export default {
	name: "Footer"
}
</script>

<style lang="scss" scoped>

  .footer {
    background-color: var(--footer-color);
    position: fixed;
    left: 0;
    bottom: 0;
    width: 100vw;
    height: 7vh;
    display: flex;
    justify-content: right;
    align-items: center;

    .logo{
      height: 60%;
      margin-right: 1%;
    }

    .names {
      color: grey;
      font-size: 0.7rem;
      margin-right: 2%;
    }

  }

</style>