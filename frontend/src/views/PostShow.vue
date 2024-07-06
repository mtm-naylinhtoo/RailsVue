<template>
  <div>
    <h2>Post Details</h2>
    <div v-if="post">
      <h3>{{ post.title }}</h3>
      <p>{{ post.body }}</p>
      <p>Created at: {{ formatDate(post.created_at) }}</p>
      <div v-if="post.user_id === current_user.id">
        <router-link :to="{ name: 'EditPost', params: { id: post.id } }" class="btn btn-sm btn-outline-primary">Edit</router-link>
        <button @click="deletePost(post.id)" class="btn btn-sm btn-outline-danger">Delete</button>
      </div>
    </div>
    <div v-else>
      <p>Loading...</p>
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
      post: null
    };
  },
  async created() {
    try {
      const postID = this.$route.params.id;
      const response = await apiService.getPost(postID);
      this.post = response.data;
    } catch (error) {
      console.error('Error fetching post:', error);
    }
  },
  methods: {
    async deletePost(postID) {
      try {
        await apiService.deletePost(postID);
        this.$router.push('/posts');
      } catch (error) {
        console.error('Error deleting post:', error);
      }
    },
    formatDate(dateString) {
      return new Date(dateString).toLocaleDateString();
    }
  }
};
</script>

<style scoped>
.btn {
  cursor: pointer;
}

.btn-outline-primary {
  color: #007bff;
  border-color: #007bff;
}

.btn-outline-primary:hover {
  background-color: #007bff;
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
</style>
