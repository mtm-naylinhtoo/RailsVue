<template>
  <div class="container-fluid py-5">
    <div class="row justify-content-center">
      <div class="col-12">
        <div class="d-flex justify-content-between align-items-center mb-4">
          <h2 class="mb-0">Posts</h2>
          <button @click="$router.push('/posts/create')" class="btn btn-dark">Create Post</button>
        </div>
        <div v-if="posts.length" class="row">
          <div v-for="post in posts" :key="post.id" class="col-md-4 mb-4">
            <div class="card h-100 post-card" @click="viewPost(post.id)">
              <div class="card-body">
                <h5 class="card-title">{{ post.title }}</h5>
                <p class="card-text">{{ truncatedBody(post.body) }}</p>
              </div>
              <div class="card-footer text-right">
                <div v-if="post.user_id === current_user.id" class="btn-group">
                  <button @click.stop="editPost(post.id)" class="btn btn-sm btn-outline-dark">Edit</button>
                  <button @click.stop="deletePost(post.id)" class="btn btn-sm btn-outline-danger">Delete</button>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div v-else class="alert">
          No posts yet. 🤔
        </div>
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
    viewPost(postID) {
      this.$router.push({ name: 'ShowPost', params: { id: postID } });
    },
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
    },
    truncatedBody(body) {
      const words = body.split(' ');
      return words.length > 20 ? words.slice(0, 20).join(' ') + '...' : body;
    }
  }
};
</script>

<style scoped>
.post-card {
  cursor: pointer;
  transition: transform 0.2s, box-shadow 0.2s;
  height: 100%;
  display: flex;
  flex-direction: column;
}

.post-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.card-body {
  flex-grow: 1;
  text-align: left;
}

.card-footer {
  background-color: #fff;
  border-top: 0;
}

.card-text {
  display: -webkit-box;
  -webkit-line-clamp: 3; /* number of lines to show */
  -webkit-box-orient: vertical;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: normal;
}

.btn-group .btn {
  margin-right: 5px;
}

.btn-group .btn:last-child {
  margin-right: 0;
}

.btn-dark, .btn-outline-dark {
  background-color: #343a40;
  color: #fff;
  border: none;
}

.btn-outline-dark:hover {
  background-color: #23272b;
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
