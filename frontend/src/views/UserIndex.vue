<template>
  <div class="container-fluid py-5">
    <div class="row justify-content-center">
      <div class="col-12">
        <div class="d-flex justify-content-between align-items-center mb-4">
          <h2 class="mb-0">Users</h2>
        </div>
        <div v-if="users.length" class="row">
          <div v-for="user in users" :key="user.id" class="col-md-4 mb-4">
            <div class="card h-100 user-card" @click="viewUser(user.id)">
              <div class="card-body">
                <h5 class="card-title">
                  <span v-if="user.id === current_user.id">
                    You 🫵
                  </span>
                  <span v-else>
                    {{ user.name }}
                  </span>
                </h5>
                <p class="card-text">{{ user.email }}</p>
              </div>
              <div v-if="user.id === current_user.id" class="card-footer text-right">
                <button @click.stop="editUser(user.id)" class="btn btn-sm btn-outline-dark">Edit</button>
                <button @click.stop="deleteUser(user.id)" class="btn btn-sm btn-outline-danger ml-2">Delete</button>
              </div>
            </div>
          </div>
        </div>
        <div v-else class="alert">
          No users yet. 🤔
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import apiService from '@/api-service';

export default {
  name: 'UserIndex',
  props: {
    current_user: {
      type: Object,
      required: true
    }
  },
  data() {
    return {
      users: []
    };
  },
  async created() {
    try {
      const response = await apiService.getUsers();
      this.users = response.data;
    } catch (error) {
      console.error('Error fetching users:', error);
    }
  },
  methods: {
    viewUser(userId) {
      this.$router.push({ name: 'ShowUser', params: { id: userId } });
    },
    editUser(userId) {
      this.$router.push({ name: 'EditUser', params: { id: userId } });
    },
    async deleteUser(userId) {
      try {
        console.log(userId);
        await apiService.deleteUser(userId);
        this.users = this.users.filter(user => user.id !== userId);
        localStorage.removeItem('token');
        this.$router.push('/login');
      } catch (error) {
        console.error('Error deleting user:', error);
      }
    }
  }
  
};
</script>

<style scoped>
.user-card {
  cursor: pointer;
  transition: transform 0.2s, box-shadow 0.2s;
  height: 100%;
  display: flex;
  flex-direction: column;
}

.user-card:hover {
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

.alert-info {
  background-color: #d1ecf1;
  border-color: #bee5eb;
  color: #0c5460;
}
</style>
