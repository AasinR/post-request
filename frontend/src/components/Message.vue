<template>
<div class="message" :class="message.FROMUSER.ID.toString() === $cookies.get('UserID').toString() ? 'sent' : 'recieved'">
  <div v-if="!editMode" class="icons">
    <img v-show="message.FROMUSER.ID.toString() === $cookies.get('UserID').toString()" id="edit-icon" src="@/assets/edit.png" alt="edit-icon" @click="editModeOn"/>
    <img v-show="message.FROMUSER.ID.toString() === $cookies.get('UserID').toString()" id="delete-icon" src="@/assets/delete.png" alt="delete-icon" @click="deleteMessage"/>
  </div>
  <textarea  id="edited-message-input"
             v-if="editMode"
             v-model="editedMessageContent"
             @blur="editMessage"
             v-on:keydown.enter.exact.prevent="editMessage"
             v-on:keydown.enter.shift.exact.prevent="editedMessageContent += '\n'"
  ></textarea>
  <p v-if="!editMode">{{message.CONTENT}}</p>
</div>
</template>

<script>
export default {
  name: "Message",
  props: {
    message: Object,
  },
  data() {
    return {
      editedMessageContent: '',
      editMode: false,
    }
  },
  methods: {
    editModeOn() {
        this.editedMessageContent = this.message.CONTENT;
        this.editMode = true;
    },

    editModeOff() {
      this.editMode = false;
      this.editedMessageContent = '';
    },

    async editMessage(){
      if(this.editedMessageContent.trim() !== '') {
        try {
          await this.axios.post(`${this.$root.requestURL}/message/update/${this.message.ID}`, {
            content: this.editedMessageContent,
          });
        } catch (err) {
          console.log(err);
        }
        this.$emit("edit");
      }
      this.editModeOff();
    },

    async deleteMessage(){
      try {
        await this.axios.get(`${this.$root.requestURL}/message/delete/${this.message.ID}`);
      } catch (err) {
        console.log(err);
      }
      this.$emit("delete");
    }
  },
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
  position: relative;

  &.sent {
    background-color: var(--accent-color);
    margin-left: auto;
  }
  &.recieved {
    background-color: var(--light-bg-color);
  }

  #edited-message-input {
    width: 15vw;
    font-family: Cambria, serif;
    border-radius: 30px;
    padding: 2% 2.5%;
    margin-right: 1vh;
    display: inline-block;
    border-color: var(--ouline-color);

    &::-webkit-scrollbar {
      display: none;
    }
  }

  p {
    margin: 0;
    display: inline;
  }

  .icons {
    display: none;

    #delete-icon {
      width: 20px;
      margin-left: 5px;

      &:hover {
        cursor: pointer;
      }

    }

    #edit-icon {
      width: 25px;


      &:hover {
        cursor: pointer;
      }
    }

    &:hover {
      display: block;
    }

  }

  &:hover {

    .icons{
      display: flex;
      align-items: center;
      justify-content: flex-start;
      position: absolute;
      left: -60px;
      top: 2px;
      width: 160%;
      height: 30px;

      #delete-icon {
        width: 20px;

        &:hover {
          cursor: pointer;
        }

      }

      #edit-icon {
        width: 25px;

        &:hover {
          cursor: pointer;
        }

      }
    }

  }
}
</style>