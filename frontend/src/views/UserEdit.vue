<template>
  <div class="container py-5">
    <div class="row justify-content-center">
      <div class="col-md-5">
        <div class="card">
          <div class="card-body">
            <h2>Edit User</h2>
            <form @submit.prevent="editUser">
              <div class="form-group mt-4">
                <label for="name">Name:</label>
                <input id="name" v-model="user.name" type="text" class="form-control input-narrow" required>
              </div>
              <div class="form-group">
                <label for="email">Email:</label>
                <input id="email" v-model="user.email" type="email" class="form-control input-narrow" required>
              </div>
              <div class="form-group">
                <label for="password">Password:</label>
                <input id="password" v-model="user.password" type="password" class="form-control input-narrow">
              </div>
              <button type="submit" class="btn btn-dark btn-narrow mt-4">Save Changes</button>
              <div v-if="error" class="alert alert-danger mt-3">
                {{ error }}
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
  name: 'UserEdit',
  props: {
    id: {
      type: String,
      required: true
    }
  },
  data() {
    return {
      user: {
        name: '',
        email: '',
        password: ''
      },
      error: ''
    };
  },
  async created() {
    console.log(this.id);
    try {
      const response = await apiService.getUser(this.id);
      this.user = response.data;
    } catch (error) {
      this.error = 'Error fetching user: ' + error.message;
    }
  },
  methods: {
    async editUser() {
      try {
        await apiService.updateUser(this.id, this.user);
        this.$router.push({ name: 'ShowUser', params: { id: this.id } });
      } catch (error) {
        this.error = 'Error editing user: ' + error.message;
      }
    }
  }
};
</script>

<style scoped>
.container {
  padding-top: 3rem;
}

.card {
  transition: transform 0.2s, box-shadow 0.2s;
  width: 100%;
}

.card:hover {
  transform: translateY(-5px);
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.input-narrow {
  width: 100%;
}

.btn-narrow {
  width: 100%;
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
