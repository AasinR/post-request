<template>
<div class="post">
  <p>{{postData.text}}</p>
  <p>{{postData.timestamp}}</p>
  <p>{{postData.picture}}</p>
  <p>{{postData.name}}</p>
</div>
</template>

<script>
export default {
  name: "Post",
  props: {
    postData: {
      id: Number,
      text: String,
      timestamp: String,
      picture: String,
      name: String
    }
  }
}
</script>

<style lang="scss" scoped>

</style>