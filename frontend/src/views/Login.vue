<template>
  <div class="login">
    <WelcomeBar/>
    <div class="login-form">
      <div class="login-title">
        <h1>To use this website, you have to log in first!</h1>
      </div>
      <div class="input-fields">
        <div class="input-group">
          <label for="email"> E-mail:</label> <br>
          <div class="input-field">
            <input type="email"  id="email" v-model="inputData.email">
          </div>
        </div>
        <div class="input-group">
          <label for="password"> Password:</label> <br>
          <div class="input-field">
            <input type="password" id="password" v-model="inputData.password">
          </div>
        </div>
        <div class="login-btn">
          <button type="submit">Log in</button>
        </div>
        <hr>
        <div class="to-register-btn">
          <button @click="sendToRegister">Create account</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import WelcomeBar from '@/components/Welcome-Bar'

export default {
  name: "Login",
  components: {
    WelcomeBar
  },

  data() {
    return {
      inputData: {
        email: '',
        password: '',
      },
    }
  },

  methods: {
    sendToRegister(){
      this.$router.replace({name: 'Register'});
    }
  },
}
</script>

<style lang="scss" scoped>

.login-form {
  position: absolute;
  top: 0;
  right: 0;
  height: 100vh;
  width: 55%;
  background-color: #253f58;
  display: flex;
  flex-direction: column;
  align-items: center;
  font-family: "Cambria",sans-serif;

  .input-fields {
    width: 40%;
    border: solid lightblue 2px;
    border-radius: 30px;
    padding: 5% 5% 2% 5%;
    font-size: 1.5rem;
    display: flex;
    flex-direction: column;
    align-items: center;
    box-shadow: 10px 10px lightblue;

    .input-group{
      width: 100%;
      margin: 5% 0 5% 0;
      .input-field {
        display: flex;
        flex-direction: column;
        align-items: center;
      }
      input {
        width: 95%;
        font-size: 1.5rem;
        margin-top: 2%;
        padding: 3% 0 3% 3%;
        border: none;
        border-radius: 20px;
      }
    }

    hr {
      width: 100%;
    }

    .to-register-btn, .login-btn {
      width: 100%;
      display: flex;
      flex-direction: column;
      align-items: center;

      button {
        margin-top: 3%;
        margin-bottom: 5%;
        font-size: 1.6rem;
        height: 3.5rem;
        background-color: #007acc;
        color: white;
        border: none;
        border-radius: 20px;
        font-weight: bold;
        font-family: "Cambria",sans-serif;
        &:hover {
          cursor: pointer;
          -webkit-filter: brightness(90%);
          transition: all 100ms ease;
        }
      }
    }

    .login-btn {
      button {
          width: 50%;
        }
    }

    .to-register-btn {
      button {
        width: 70%;
      }
    }

  }

  h1 {
    font-size: 2.5rem;
    margin-top: 25%;
    margin-bottom: 15%
  }

}

</style>