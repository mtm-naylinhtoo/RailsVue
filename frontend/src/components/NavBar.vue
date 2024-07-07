<template>
  <nav class="navbar navbar-expand-lg">
    <router-link v-if="isAuth" to="/" class="navbar-brand">datawow</router-link>
    
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav mr-auto">
        <li v-if="isAuth" class="nav-item">
          <router-link to="/posts" class="nav-link">Posts</router-link>
        </li>
        <li v-if="isAuth" class="nav-item">
          <router-link to="/users" class="nav-link">Users</router-link>
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
          <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdown">
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
.navbar {
  background-color: #fff;
  border: 1px solid rgba(0, 0, 0, 0.125);
  box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
}
.navbar-brand {
  font-weight: bold;
  cursor: pointer; /* Make navbar-brand clickable */
}
.navbar-brand,
.navbar-nav .nav-link {
  color: #343a40;
}

.navbar-toggler {
  border-color: #343a40;
}

.navbar-toggler-icon {
  background-color: transparent; /* Set the background color of the icon to transparent */
  border: none; /* Remove any border */
  outline: none; /* Remove outline */
}

.navbar-toggler-icon::after {
  content: '\2630'; /* Add the hamburger icon content */
  color: #343a40; /* Set the color of the hamburger icon */
  font-size: 1.5rem; /* Adjust the font size as needed */
}

.dropdown-menu {
  background-color: #fff; 
  border: 1px solid rgba(0, 0, 0, 0.125);
  box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
}

.dropdown-menu .dropdown-item {
  color: #343a40;
}

.dropdown-menu .dropdown-item:hover {
  background-color: #f8f9fa;
}
</style>
