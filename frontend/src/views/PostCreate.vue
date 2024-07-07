<template>
  <div class="container py-5">
    <div class="row justify-content-center">
      <div class="col-md-5">
        <div class="card">
          <div class="card-body">
            <h2>Create Post</h2>
            <form @submit.prevent="createPost">
              <div class="form-group mt-4">
                <label for="title">Title:</label>
                <input id="title" v-model="post.title" type="text" class="form-control" required>
              </div>
              <div class="form-group">
                <label for="body">Body:</label>
                <textarea id="body" v-model="post.body" class="form-control" required></textarea>
              </div>
              <button type="submit" class="btn btn-dark btn-block mt-4">Create Post</button>
              <div v-if="error" class="alert mt-3">
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
  name: 'PostCreate',
  data() {
    return {
      post: {
        title: '',
        body: ''
      },
      error: ''
    };
  },
  methods: {
    async createPost() {
      try {
        await apiService.createPost(this.post);
        this.$router.push('/posts');
      } catch (error) {
        this.error = 'Error creating post: ' + error.message;
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
