<template>
  <div class="container-fluid py-5">
    <div class="row justify-content-center">

      <div class="col-md-8">
        <div class="card mb-4">
          <div class="card-body">
            <h2>User Details</h2>
            <div v-if="user" class="mt-4">
              <h3>{{ user.name }}</h3>
              <p>Email: {{ user.email }}</p>
              <div v-if="user.id === current_user.id" class="btn-group">
                <router-link :to="{ name: 'EditUser', params: { id: user.id } }" class="btn btn-sm btn-outline-dark">Edit</router-link>
                <button @click="deleteUser(user.id)" class="btn btn-sm btn-outline-danger">Delete</button>
              </div>
            </div>
            <div v-else>
              <p>Loading...</p>
            </div>
            <div v-if="error" class="alert alert-danger mt-3">
              {{ error }}
            </div>
          </div>
        </div>
      </div>

      <div class="col-md-8">
        <div class="card">
          <div class="card-body">
            <h2>User Posts</h2>
            <div v-if="user && user.posts.length > 0">
              <div class="row">
                <div v-for="post in user.posts" :key="post.id" class="col-md-6 mb-3">
                  <div class="card">
                    <div class="card-body">
                      <h5 class="card-title">{{ post.title }}</h5>
                      <p class="card-text">{{ post.body }}</p>
                      <router-link :to="{ name: 'ShowPost', params: { id: post.id } }" class="btn btn-sm btn-outline-primary">View Post</router-link>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div v-else class="pt-4">
              <p>No posts yet. 🤔</p>
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
  name: 'UserShow',
  props: {
    current_user: {
      type: Object,
      required: true
    }
  },
  data() {
    return {
      user: null,
      error: ''
    };
  },
  async created() {
    try {
      const userID = this.$route.params.id;
      const response = await apiService.getUser(userID);
      this.user = response.data;
    } catch (error) {
      this.error = 'Error fetching user: ' + error.message;
    }
  },
  methods: {
    async deleteUser(userID) {
      try {
        await apiService.deleteUser(userID);
        localStorage.removeItem('token');
        this.$router.push('/login');
      } catch (error) {
        this.error = 'Error deleting user: ' + error.message;
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
  transition: transform 0.2s, box-shadow 0.2s;
}

.card:hover {
  transform: translateY(-5px);
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.btn-group .btn {
  margin-right: 5px;
}

.btn-group .btn:last-child {
  margin-right: 0;
}

.btn-outline-dark {
  color: #343a40;
  border-color: #343a40;
}

.btn-outline-dark:hover {
  background-color: #343a40;
  color: #fff;
}

.btn-outline-danger {
  color: #dc3545;
  border-color: #dc3545;
}

.btn-outline-danger:hover {
  background-color: #dc3545;
  color: #fff;
}

.btn-outline-primary {
  color: #007bff;
  border-color: #007bff;
}

.btn-outline-primary:hover {
  background-color: #007bff;
  color: #fff;
}

.alert {
  margin-top: 1rem;
}
</style>
