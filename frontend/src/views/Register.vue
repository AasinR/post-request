<template>
  <div class="register">
    <WelcomeBar/>
    <div class="register-form">
      <div class="register-title">
        <h1>Registration</h1>
      </div>
      <div class="input-fields">
        <div class="name-group">
          <div class="input-group firstname">
            <label for="firstname"> First name:</label> <br>
            <div class="input-field">
              <input type="text"  id="firstname" v-model="inputData.firstName">
            </div>
          </div>
          <div class="input-group last-name">
            <label for="lastname"> Last name:</label> <br>
            <div class="input-field">
              <input type="text"  id="lastname" v-model="inputData.lastName" >
            </div>
          </div>
        </div>
        <div class="input-group">
          <label for="email"> E-mail:</label> <br>
          <div class="input-field">
            <input type="email"  id="email" v-model="inputData.email" >
          </div>
        </div>
        <div class="input-group">
          <label for="password"> Password:</label> <br>
          <div class="input-field">
            <input type="password" id="password" v-model="inputData.password" >
          </div>
        </div>
        <div class="input-group">
          <label for="password-again"> Password again:</label> <br>
          <div class="input-field">
            <input type="password" id="password-again" v-model="inputData.passwordAgain" >
          </div>
        </div>
<!--        <div class="input-group">-->
<!--          <label for="phone-number"> Phone number:</label> <br>-->
<!--          <div class="input-field">-->
<!--            <input type="tel" id="phone-number" v-model="inputData.phoneNumber" >-->
<!--          </div>-->
<!--        </div>-->
<!--        <div class="input-group">-->
<!--          <label for="profession"> Current workplace/school:</label> <br>-->
<!--          <div class="input-field">-->
<!--            <input type="text" id="profession" v-model="inputData.profession">-->
<!--          </div>-->
<!--        </div>-->
<!--        <div class="input-group">-->
<!--          <label for="birthdate"> Date of birth:</label> <br>-->
<!--          <div class="input-field">-->
<!--            <input type="date" id="birthdate" v-model="inputData.birthDate">-->
<!--          </div>-->
<!--        </div>-->
<!--        <div class="input-group">-->
<!--          <p>Gender:</p> <br>-->
<!--          <div class="input-field radio-field">-->
<!--            <input class="radio-input" type="radio" id="male" name="gender" value="male" v-model="inputData.gender">-->
<!--            <label for="male">Male</label>-->
<!--            <input class="radio-input" type="radio" id="female"  name="gender" value="female" v-model="inputData.gender">-->
<!--            <label for="female">Female</label>-->
<!--            <input class="radio-input" type="radio" id="custom" name="gender" value="custom" v-model="inputData.gender">-->
<!--            <label for="custom">Custom</label>-->
<!--          </div>-->
<!--        </div>-->
        <div class="register-btn">
          <button type="submit" @click="register">Sign up</button>
        </div>
        <div class="send-to-login">
          <p>
            Already have an account?
            <br>
            <router-link class="login-link" :to="{name: 'Login'}">Log in here!</router-link>
          </p>
        </div>
      </div>
    </div>
  </div>

</template>

<script>
import WelcomeBar from "@/components/Welcome-Bar";
export default {
  name: "Register",

  data() {
    return {
      inputData: {
        firstName: '',
        lastName: '',
        email: '',
        password: '',
        passwordAgain: '',
        // phoneNumber: '',
        // profession: '',
        // birthDate: '',
        // gender: 'male',
      },
    }
  },
  methods: {
    async register(){
      try {
        const result = await this.axios.post(`${this.$root.requestURL}/register`,{
          firstName: this.inputData.firstName,
          lastName: this.inputData.lastName,
          email: this.inputData.email,
          password: this.inputData.password,
        })

      } catch (err) {

      }

    }
  },

  components: {
    WelcomeBar
  },
}
</script>

<style lang="scss" scoped>

.register {
  height: 100%;

  .register-form {
    position: absolute;
    top: 0;
    right: 0;
    height: 100vh;
    width: 55%;
    background-color: var(--light-bg-color);
    display: flex;
    flex-direction: column;
    align-items: center;
    font-family: "Cambria", sans-serif;


    .input-fields {
      width: 40%;
      border: solid 2px var(--ouline-color);
      border-radius: 30px;
      padding: 3% 5% 2% 5%;
      font-size: 1.2rem;
      display: flex;
      flex-direction: column;
      align-items: center;
      box-shadow: 10px 10px var(--ouline-color);

      .input-group {
        width: 100%;
        margin: 2% 0 2% 0;

        .input-field {
          display: flex;
          flex-direction: column;
          align-items: center;

          //&.radio-field {
          //  display: flex;
          //  flex-direction: row;
          //  align-items: center;
          //
          //  .radio-input {
          //    margin: 0 0 0 3%;
          //    width: 3rem;
          //  }
          //}

          input {
            width: 95%;
            font-size: 1rem;
            margin-top: 2%;
            padding: 2% 2% 2% 3%;
            border: none;
            border-radius: 20px;
          }

        }

      }

      .send-to-login {
        p {
          font-size: 1rem;
          text-align: center;

          .login-link {
            color: var(--font-color);;
          }
        }
      }

      p {
        margin: 0;
      }


      .name-group {
        width: 100%;

        .input-group {
          display: inline-block;
          width: 48%;

          &.firstname {
            margin-right: 2%;
          }

          input {
            padding: 4% 2% 4% 3%;
          }
        }
      }

      .register-btn {
        width: 100%;
        display: flex;
        flex-direction: column;
        align-items: center;

        button {
          width: 50%;
          margin-top: 5%;
          margin-bottom: 3%;
          font-size: 1.6rem;
          height: 3.5rem;
          background-color: var(--accent-color);
          color: var(--font-color);
          border: none;
          border-radius: 20px;
          font-weight: bold;
          font-family: "Cambria", sans-serif;

          &:hover {
            cursor: pointer;
            -webkit-filter: brightness(90%);
            transition: all 100ms ease;
          }
        }
      }
    }

    .register-title {
      width: 50%;
      h1 {
        text-align: left;
        font-size: 2.5rem;
        margin-top: 15%;
        margin-bottom: 15%
      }
    }

  }
}

</style>