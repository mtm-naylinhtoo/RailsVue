<template>
  <form @submit.prevent="signup">
    <label>Name:</label>
    <input v-model="formData.name" type="text" required><br><br>
    
    <label>Email:</label>
    <input v-model="formData.email" type="email" required><br><br>
    
    <label>Password:</label>
    <input v-model="formData.password" type="password" required><br><br>
    
    <button type="submit">Sign Up</button>
  </form>
</template>

<script>
import axiosInstance from '../axios-instance';

export default {
  data() {
    return {
      formData: {
        name: '',
        email: '',
        password: ''
      }
    };
  },
  methods: {
    async signup() {
      try {
        const response = await axiosInstance.post('/signup', {
          user: this.formData
        });
        console.log('Signup successful:', response.data);
        this.$router.push('/login');
      } catch (error) {
        console.error('Error signing up:', error);
      }
    }
  }
};
</script>
