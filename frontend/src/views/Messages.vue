<template>
  <div class="messages">
    <Header/>
    <Navbar current="messages"/>
    <div v-if="loadDone" class="content">
      <div v-if="zeroFriends" class="no-friends">
        <h1>You don't have any friends to message yet!</h1>
      </div>
      <div v-if="!zeroFriends" class="friend-list">
        <MessagesFriend v-for="(friend, index) in friends" :key="index" :friend="friend" :current-friend-id="currentFriendID" @chooseFriend="changeMessages(friend)"/>
      </div>
      <div v-if="!zeroFriends" class="private-messages-box">
        <div class="private-messages">
          <p class="zeroMessages" v-if="zeroMessages">There are no messages yet</p>
          <Message v-for="(message, index) in messages" :key="index" :message="message" @edit="initMessages" @delete="initMessages"/>
        </div>
        <div class="new-message-container">
          <textarea id="new-message"
                    v-model="newMessageContent"
                    v-on:keydown.enter.exact.prevent="sendMessage"
                    v-on:keydown.enter.shift.exact.prevent="newMessageContent += '\n'"
                    rows="1"
                    placeholder="Send a message..."
          ></textarea>
          <img @click="sendMessage" id="send-img" src="@/assets/send.png" alt="send-img"/>
        </div>
      </div>
    </div>
    <Footer/>
  </div>
</template>

<script>
import Header from "@/components/Header";
import Navbar from "@/components/Navbar";
import Footer from "@/components/Footer";
import MessagesFriend from "@/components/Messages-Friend";
import Message from "@/components/Message";

export default {
  name: "Messages",
  components: {Message, Footer, Navbar, Header, MessagesFriend},
  data(){
    return{
      friends: [],
      messages: [],

      newMessageContent: '',
      currentFriendID: 0,
      zeroMessages: false,
      zeroFriends: true,
      loadDone: false,
    }
  },
  methods: {
    async initFriends(){
      try {
        const response = await this.axios.get(`${this.$root.requestURL}/friend/getall/${this.$cookies.get('UserID')}`);
        this.friends = response.data.result;
      } catch (err) {
        console.log(err.response.data);
      }

      if(this.friends[0] === undefined || this.friends[0] === null){
        this.zeroFriends = true;
      } else {
        this.zeroFriends = false;
        this.currentFriendID = this.friends[0].ID;
        await this.initMessages();
      }
      this.loadDone = true;
    },

    async initMessages(){
      try {
        const response = await this.axios.get(`${this.$root.requestURL}/message/getMessaging/${this.currentFriendID}`);
        this.messages = response.data.result;
      } catch (err) {
        console.log(err.response.data);
      }

      this.zeroMessages = this.messages[0] === undefined || this.messages[0] === null;
    },

    changeMessages(friend){
      this.currentFriendID = friend.ID;
      this.initMessages();
    },

    async sendMessage(){
      if(this.newMessageContent.trim() !== '') {
        try {
          await this.axios.post(`${this.$root.requestURL}/message/send`, {
            content: this.newMessageContent,
            touser: this.currentFriendID,
          })
        } catch (err) {
          console.log(err.response.data);
        }
        await this.initMessages();
        this.newMessageContent = '';
      }
    },
  },
  mounted() {
    this.initFriends();
  }
}
</script>

<style lang="scss" scoped>

  .messages{
    padding-top: 8vh;
    padding-bottom: 10vh;
    .content {
      margin-left: auto;
      margin-right: auto;
      width: 60%;
      display: flex;
      flex-direction: row;

      .no-friends{
        margin-left: auto;
        margin-right: auto;

      }

      .friend-list, .private-messages {
        overflow-y: auto;
        overflow-x: hidden;
      }

      .friend-list {
        width: 35%;
        margin-right: 2%;
        padding: 0.5% 2% 2% 2%;

      }
      .private-messages{
        height: 90%;
        display: flex;
        flex-direction: column-reverse;
        padding-right: 3%;

        .zeroMessages {
          color: var(--lighter-bg-color);
          font-size: 20px;
          align-self: center;
        }
      }
      .private-messages-box {
        height: 65vh;
        border: solid 2px var(--ouline-color);
        border-radius: 30px;
        width: 63%;
        padding: 2%;
        display: flex;
        flex-direction: column;

        .new-message-container {
          display: flex;
          align-items: center;
          margin-top: auto;
          margin-left: auto;
          margin-right: auto;
          width: 90%;

          #new-message {
            width: 90%;
            border-radius: 15px;
            overflow: hidden;
            padding: 1% 2%;
            font-family: Cambria, serif;
            resize: none;
          }

          #send-img {
            width: 5%;
            margin-left: 2%;

            &:hover {
              cursor: pointer;
              -webkit-filter: brightness(85%);
              transition: all 100ms ease;
            }
          }
        }
      }
    }

    /* width */
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
  }

</style>