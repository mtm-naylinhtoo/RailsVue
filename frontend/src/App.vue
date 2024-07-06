<!-- src/App.vue -->
<template>
  <div id="app">
    <NavBar :isAuth="isLoggedIn" :current_user="current_user" @logout="handleLogout" />
    <router-view :current_user="current_user" class="mt-4" />
  </div>
</template>

<script>
import { ref, watch } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import apiService from './api-service';
import { jwtDecode } from 'jwt-decode';
import NavBar from './components/NavBar.vue';

export default {
  name: 'App',
  components: {
    NavBar
  },
  setup() {
    const isLoggedIn = ref(false);
    const current_user = ref({});
    const route = useRoute();
    const router = useRouter();

    watch(route, () => {
      const userToken = localStorage.getItem('token');
      isLoggedIn.value = !!userToken;
      if (isLoggedIn.value) {
        const userID = jwtDecode(userToken).sub;
        apiService.getUser(userID)
          .then(user => {
            current_user.value = user.data;
          })
          .catch(error => {
            console.error('Fail to get current user', error);
          });
      }
    });

    const handleLogout = () => {
      localStorage.removeItem('token');
      isLoggedIn.value = false;
      current_user.value = {};
      router.push('/login');
    };

    return {
      isLoggedIn,
      current_user,
      handleLogout
    };
  }
};
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}
</style>
