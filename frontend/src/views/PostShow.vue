<template>
  <div class="container-fluid py-5">
    <div class="row justify-content-center">
      <div class="col-md-5">
        <div class="card">
          <div class="card-body">
            <h2>Post Details</h2>
            <div v-if="post" class="mt-4">
              <h3>{{ post.title }}</h3>
              <p>{{ post.body }}</p>
              <p>Created at: {{ formatDate(post.created_at) }}</p>
              <div v-if="post.user_id === current_user.id" class="btn-group">
                <router-link :to="{ name: 'EditPost', params: { id: post.id } }" class="btn btn-sm btn-outline-dark">Edit</router-link>
                <button @click="deletePost(post.id)" class="btn btn-sm btn-outline-danger">Delete</button>
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
    </div>
  </div>
</template>

<script>
import apiService from '@/api-service';

export default {
  name: 'PostShow',
  props: {
    current_user: {
      type: Object,
      required: true
    }
  },
  data() {
    return {
      post: null,
      error: ''
    };
  },
  async created() {
    try {
      const postID = this.$route.params.id;
      const response = await apiService.getPost(postID);
      this.post = response.data;
    } catch (error) {
      this.error = 'Error fetching post: ' + error.message;
    }
  },
  methods: {
    async deletePost(postID) {
      try {
        await apiService.deletePost(postID);
        this.$router.push('/posts');
      } catch (error) {
        this.error = 'Error deleting post: ' + error.message;
      }
    },
    formatDate(dateString) {
      return new Date(dateString).toLocaleDateString();
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

.alert {
  margin-top: 1rem;
}
</style>
