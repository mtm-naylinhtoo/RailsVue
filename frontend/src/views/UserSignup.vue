<template>
  <div class="container-fluid py-5">
    <div class="row justify-content-center">
      <div class="col-md-4">
        <div class="card">
          <div class="card-body">
            <h2>Sign Up</h2>
            <form @submit.prevent="signup">
              <div class="form-group mt-4">
                <input v-model="formData.name" type="text" class="form-control input-narrow" placeholder="Name" required />
              </div>
              <div class="form-group">
                <input v-model="formData.email" type="email" class="form-control input-narrow" placeholder="Email" required />
              </div>
              <div class="form-group">
                <input v-model="formData.password" type="password" class="form-control input-narrow" placeholder="Password" required />
              </div>
              <button type="submit" class="btn btn-dark btn-narrow mt-4">Sign Up</button>
              <div v-if="error" class="alert mt-3">
                <span>{{ error }}</span>
              </div>
            </form>
            <div class="mt-3">
              <p>Already have an account? <router-link to="/login">Sign In</router-link></p>
            </div>
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
      formData: {
        name: '',
        email: '',
        password: ''
      },
      error: ''
    };
  },
  methods: {
    async signup() {
      try {
        const response = await apiService.signup(this.formData);
        console.log('Signup successful:', response.data);
        this.$router.push('/login');
      } catch (error) {
        this.error = 'Error signing up. Please try again.';
        console.error('Error signing up:', error);
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
  text-align: center; /* Center align error message */
}

.alert span {
  display: inline-block;
  max-width: 100%; /* Ensure error message doesn't overflow */
}

p {
  text-align: center; /* Center align "Already have an account?" text */
  margin-top: 1rem;
}
</style>
