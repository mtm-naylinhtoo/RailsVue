<!-- src/components/Login.vue -->
<template>
  <div>
    <h2>Log In</h2>
    <form @submit.prevent="logIn">
      <input v-model="email" type="email" placeholder="Email" />
      <input v-model="password" type="password" placeholder="Password" />
      <button type="submit">Log In</button>
    </form>
  </div>
</template>

<script>
import axiosInstance from '../axios-instance';

export default {
  data() {
    return {
      email: '',
      password: ''
    };
  },
  methods: {
    async logIn() {
      try {
        const response = await axiosInstance.post('/login', {
          user: {
            email: this.email,
            password: this.password
          }
        });
        localStorage.setItem('token', response.data.status.token);
        this.$router.push('/');
      } catch (error) {
        console.error(error);
      }
    }
  }
};
</script>
