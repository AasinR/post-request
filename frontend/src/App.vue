<template>
  <div id="app">
    <router-view :key="$route.fullPath"/>
  </div>
</template>

<style lang="scss">
@import url("style/colors.css");

body {
    margin: 0;
    padding: 0;
    color: var(--font-color);
    background-color: var(--dark-bg-color);
}

html {
  font-size: 16px;
}



</style>
