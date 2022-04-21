<template>
<div class="message" :class="message.FROMUSER.ID.toString() === $cookies.get('UserID').toString() ? 'sent' : 'recieved'">
  <p>{{message.CONTENT}}</p>
</div>
</template>

<script>
export default {
  name: "Message",
  props: {
    message: Object,
  }
}
</script>

<style lang="scss" scoped>
.message {
  border-radius: 30px;
  margin-top: 2%;
  max-width: 60%;
  width: fit-content;
  word-wrap: break-word;
  padding: 2% 2.5%;

  &.sent {
    background-color: var(--accent-color);
    margin-left: auto;
  }
  &.recieved {
    background-color: var(--light-bg-color);
  }

  p {
    margin: 0;
    display: inline;
  }
}
</style>