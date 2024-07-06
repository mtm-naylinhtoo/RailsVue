
<template>
  <div>
    <h2>Edit Post</h2>
    <form @submit.prevent="editPost">
      <label>Title:</label>
      <input v-model="post.title" type="text" required><br><br>
      
      <label>Body:</label>
      <textarea v-model="post.body" required></textarea><br><br>
      
      <button type="submit">Save Changes</button>
    </form>
  </div>
</template>

<script>
import apiService from '@/api-service';

export default {
  name: 'PostEdit',
  props: {
    id: {
      type: String,
      required: true
    }
  },
  data() {
    return {
      post: {
        title: '',
        body: ''
      }
    };
  },
  async created() {
    console.log(this.id);
    try {
      const response = await apiService.getPost(this.id);
      this.post = response.data;
    } catch (error) {
      console.error('Error fetching post:', error);
    }
  },
  methods: {
    async editPost() {
      try {
        await apiService.updatePost(this.id, this.post);
        this.$router.push({ name: 'ShowPost', params: { id: this.id } });
      } catch (error) {
        console.error('Error editing post:', error);
      }
    }
  }
};
</script>
