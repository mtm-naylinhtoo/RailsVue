<template>
  <div>
    <h2>Create Post</h2>
    <form @submit.prevent="PostCreate">
      <label>Title:</label>
      <input v-model="post.title" type="text" required><br><br>
      
      <label>Body:</label>
      <textarea v-model="post.body" required></textarea><br><br>
      
      <button type="submit">Create Post</button>
    </form>
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
      }
    };
  },
  methods: {
    async PostCreate() {
      try {
        await apiService.createPost(this.post);
        this.$router.push('/posts');
      } catch (error) {
        console.error('Error creating post:', error);
      }
    }
  }
};
</script>
