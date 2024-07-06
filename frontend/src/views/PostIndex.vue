<template>
  <div>
    <h2>Posts</h2>
    <button @click="$router.push('/posts/create')" class="btn btn-primary mb-3">Create Post</button>
    <div class="table-container">
      <table v-if="posts.length" class="table table-striped">
        <thead class="thead-light">
          <tr>
            <th>Title</th>
            <th>Body</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="post in posts" :key="post.id">
            <td><router-link :to="{ name: 'ShowPost', params: { id: post.id } }">{{ post.title }}</router-link></td>
            <td>{{ post.body }}</td>
            <td>
              <div v-if="post.user_id === current_user.id">
                <button @click="editPost(post.id)" class="btn btn-sm btn-outline-primary">Edit</button>
                <button @click="deletePost(post.id)" class="btn btn-sm btn-outline-danger">Delete</button>
              </div>
            </td>
          </tr>
        </tbody>
      </table>
      <div v-else>
        No posts found.
      </div>
    </div>
  </div>
</template>

<script>
import apiService from '@/api-service';

export default {
  name: 'PostsComponent',
  props: {
    current_user: {
      type: Object,
      required: true
    }
  },
  data() {
    return {
      posts: []
    };
  },
  async created() {
    try {
      const response = await apiService.getPosts();
      this.posts = response.data;
    } catch (error) {
      console.error('Error fetching posts:', error);
    }
  },
  methods: {
    editPost(postID) {
      this.$router.push({ name: 'EditPost', params: { id: postID } });
    },
    async deletePost(postID) {
      try {
        await apiService.deletePost(postID);
        this.posts = this.posts.filter(post => post.id !== postID);
      } catch (error) {
        console.error('Error deleting post:', error);
      }
    }
  }
};
</script>

<style scoped>
.table-container {
  margin: 10px 0;
}

/* Bootstrap classes for table */
.table {
  width: 100%;
  border-collapse: collapse;
}

.table th, .table td {
  padding: 8px;
  text-align: left;
  border-bottom: 1px solid #dee2e6;
}

.table th {
  background-color: #f2f2f2;
}

/* Button styles */
.btn {
  cursor: pointer;
}

.btn-primary {
  background-color: #007bff;
  color: #fff;
  border: none;
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
