<template>
  <div class="container-fluid py-5">
    <div class="row justify-content-center">
      <div class="col-md-4">
        <div class="card">
          <div class="card-body">
            <h2>Log In</h2>
            <form @submit.prevent="logIn">
              <div class="form-group mt-4">
                <input v-model="email" type="email" class="form-control input-narrow" placeholder="Email" required />
              </div>
              <div class="form-group">
                <input v-model="password" type="password" class="form-control input-narrow" placeholder="Password" required />
              </div>
              <button type="submit" class="btn btn-dark btn-narrow mt-4">Log In</button>
              <div v-if="error" class="alert mt-3">
                {{ error }}
              </div>
              <div class="mt-3">
                <p>Don't have an account? <router-link to="/signup">Sign Up</router-link></p>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import apiService from '@/api-service';

export default {
  data() {
    return {
      email: '',
      password: '',
      error: ''
    };
  },
  methods: {
    async logIn() {
      try {
        const response = await apiService.login(this.email, this.password);
        localStorage.setItem('token', response.data.status.token);
        this.$router.push('/');
      } catch (error) {
        this.error = 'Invalid email or password. Please try again.';
        console.error('Login error:', error);
      }
    }
  }
};
</script>

<style scoped>
.container-fluid {
  padding-top: 3rem;
}

.card {
  transition: none; /* No hover effect */
}

.input-narrow {
  width: 90%; /* Adjust as needed */
  margin-left: auto;
  margin-right: auto;
}

.btn-narrow {
  width: 90%; /* Adjust as needed */
  display: block;
  margin-left: auto;
  margin-right: auto;
}

.btn-dark {
  background-color: #343a40;
  color: #fff;
  border: none;
}

.btn-dark:hover {
  background-color: #23272b;
  color: #fff;
}

.alert {
  margin-top: 1rem;
}
</style>
