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

::-webkit-scrollbar {
  width: 10px;
}

/* Track */
::-webkit-scrollbar-track {
  box-shadow: inset 0 0 5px var(--ouline-color);
  border-radius: 10px;
}

/* Handle */
::-webkit-scrollbar-thumb {
  background: var(--ouline-color);
  border-radius: 10px;
}
/* Handle on hover */
::-webkit-scrollbar-thumb:hover {
  background: #85a3b0;
}

html {
  font-size: 16px;
}



</style>
