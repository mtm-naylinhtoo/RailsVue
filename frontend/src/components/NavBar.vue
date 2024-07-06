<!-- src/components/NavBar.vue -->
<template>
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <router-link to="/posts" class="navbar-brand">datawow</router-link>
    
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav mr-auto">
        <li v-if="isAuth" class="nav-item">
          <router-link to="/posts" class="nav-link">Posts</router-link>
        </li>
      </ul>
      
      <ul class="navbar-nav ml-auto">
        <li v-if="!isAuth" class="nav-item">
          <router-link to="/login" class="nav-link">Sign In</router-link>
        </li>
        <li v-if="!isAuth" class="nav-item">
          <router-link to="/signup" class="nav-link">Sign Up</router-link>
        </li>
        <li v-if="isAuth" class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            {{ current_user.name }}
          </a>
          <div class="dropdown-menu" aria-labelledby="navbarDropdown">
            <button @click="logout" class="dropdown-item">Logout</button>
          </div>
        </li>
      </ul>
    </div>
  </nav>
</template>

<script>
export default {
  name: 'NavBar',
  props: {
    isAuth: {
      type: Boolean,
      required: true
    },
    current_user: {
      type: Object,
      required: false,
      default: () => ({})
    }
  },
  methods: {
    logout() {
      localStorage.removeItem('token');
      this.$emit('logout');
    }
  }
};
</script>

<style scoped>
/* Add any custom scoped styles here */
</style>
